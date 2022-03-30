import 'package:asap_game/data/local/user/user_local_data_source.dart';
import 'package:asap_game/data/mappers/user/user_mapper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/user_entity.dart';
import '../../../infra/constants/endpoints/firestore/firestore_endpoints.dart';
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
  Future<void> saveCurrentUser(UserEntity user) async {
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
      return;
    });
  }

  @override
  Future<UserEntity> getCurrentUser() async {
    final userCollectionRef = firestore.collection(FirestoreEndpoints.users);
    final uid = await getCurrentUId();
    final user =
        UserMapper.fromSnapshotToEntity(await userCollectionRef.doc(uid).get());
    userLocalDataSource.saveUser(user);
    return UserMapper.modelToEntity(user);
  }

  @override
  Future<String> getCurrentUId() async => auth.currentUser!.uid;

  @override
  Future<bool> isSignIn() async => auth.currentUser?.uid != null;

  @override
  Future<void> signIn(UserEntity user) async => auth.signInWithEmailAndPassword(
      email: user.email!, password: user.password!);

  @override
  Future<void> signInGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        saveCurrentUser(UserEntity(
          name: userCredential.user!.displayName,
          email: userCredential.user!.email,
          picture: userCredential.user!.photoURL,
          status: "online",
        ));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          print('account-exists-with-different-credential');
        } else if (e.code == 'invalid-credential') {
          print('invalid-credential');
        }
      } catch (e) {
        print('ERROR $e');
      }
    }
  }

  @override
  Future<void> signOut() async {
    auth.signOut();
    userLocalDataSource.clearUser();
  }

  @override
  Future<void> signUp(UserEntity user) async =>
      auth.createUserWithEmailAndPassword(
          email: user.email!, password: user.password!);
}
