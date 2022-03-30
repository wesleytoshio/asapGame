import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@module
abstract class FirebaseInjectableModule {
  @lazySingleton
  FirebaseAuth get auth => FirebaseAuth.instance;
  @lazySingleton
  FirebaseFirestore get fireStore => FirebaseFirestore.instance;
}
