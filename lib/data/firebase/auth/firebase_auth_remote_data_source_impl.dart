import 'package:asap_game/data/local/user/user_local_data_source.dart';
import 'package:asap_game/data/mappers/user/user_mapper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/user_entity.dart';
import '../../../infra/constants/endpoints/firestore/firestore_endpoints.dart';
import '../../../infra/exceptions/auth_failure.dart';
import '../../models/user/user_model.dart';
import 'firebase_auth_remote_data_source.dart';

@LazySingleton(as: FirebaseAuthRemoteDataSource)
class FirebaseAuthRemoteDataSourceImpl implements FirebaseAuthRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final UserLocalDataSource userLocalDataSource;
  FirebaseAuthRemoteDataSourceImpl({
    required this.auth,
    required this.firestore,
    required this.userLocalDataSource,
  });

  @override
  Future<Either<AuthFailure, Unit>> saveCurrentUser(UserEntity user) async {
    try {
      final userCollectionRef = firestore.collection(FirestoreEndpoints.users);
      final uid = await getCurrentUId();
      userCollectionRef.doc(uid).get().then((value) {
        final newUser = UserModel(
          uid: uid,
          status: user.status,
          email: user.email,
          name: user.name,
          picture: user.picture,
        );
        var json = newUser.toJson();
        json.remove('password');
        if (!value.exists) {
          userCollectionRef.doc(uid).set(json);
          userLocalDataSource.saveUser(newUser);
        }
      });
      return right(unit);
    } on FirebaseAuthException catch (e) {
      return left(AuthNotFoundFailure(error: e.message!));
    } catch (e) {
      return left(AuthServerErrorFailure(error: e.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, UserEntity>> getCurrentUser() async {
    try {
      final uid = await getCurrentUId();
      final userCollectionRef = firestore.collection(FirestoreEndpoints.users);
      final user = UserMapper.fromSnapshotToEntity(
          await userCollectionRef.doc(uid).get());
      //userLocalDataSource.saveUser(user);
      return right(UserMapper.modelToEntity(user));
    } on FirebaseAuthException catch (e) {
      return left(AuthNotFoundFailure(error: e.message!));
    } catch (e) {
      return left(AuthServerErrorFailure(error: e.toString()));
    }
  }

  @override
  Future<String> getCurrentUId() async => auth.currentUser!.uid;

  @override
  Future<Either<AuthFailure, bool>> isSignIn() async {
    try {
      return right(auth.currentUser?.uid != null);
    } on FirebaseAuthException catch (e) {
      return left(AuthNotFoundFailure(error: e.message!));
    } catch (e) {
      return left(AuthServerErrorFailure(error: e.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signIn(UserEntity user) async {
    try {
      print('auth with ${user.email}');
      UserCredential credentials = await auth.signInWithEmailAndPassword(
          email: user.email!, password: user.password!);
      print('credentials ${credentials.user!.email}');
      return right(unit);
    } on FirebaseAuthException catch (e) {
      return left(AuthNotFoundFailure(error: e.message!));
    } catch (e) {
      return left(AuthServerErrorFailure(error: e.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential =
          await auth.signInWithCredential(credential);
      saveCurrentUser(UserEntity(
        name: userCredential.user!.displayName,
        email: userCredential.user!.email,
        picture: userCredential.user!.photoURL,
        status: "online",
      ));
      return right(unit);
    } on FirebaseAuthException catch (e) {
      return left(AuthNotFoundFailure(error: e.message!));
    } catch (e) {
      return left(AuthServerErrorFailure(error: e.toString()));
    }
  }

  @override
  Future<void> signOut() => Future.wait([
        // googleSignIn.signOut(),
        auth.signOut(),
        userLocalDataSource.clearUser()
      ]);

  @override
  Future<Either<AuthFailure, Unit>> signUp(UserEntity user) async {
    try {
      auth.createUserWithEmailAndPassword(
          email: user.email!, password: user.password!);
      saveCurrentUser(user);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      return left(AuthNotFoundFailure(error: e.message!));
    } catch (e) {
      return left(AuthServerErrorFailure(error: e.toString()));
    }
  }
}
