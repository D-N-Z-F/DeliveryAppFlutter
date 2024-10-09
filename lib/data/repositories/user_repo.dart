import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app_flutter/data/models/user.dart' as models;
import 'package:delivery_app_flutter/utils/helpers/helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepo {
  static final UserRepo _instance = UserRepo._init();
  factory UserRepo() => _instance;
  UserRepo._init();

  final _collection = FirebaseFirestore.instance.collection("users");
  final _auth = FirebaseAuth.instance;

  Future<void> login(String email, String password) async {
    await Helpers.globalErrorHandler(
      () => _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ),
    );
  }

  Future<void> register(String username, String email, String password,
      String confirmPassword) async {
    await Helpers.globalErrorHandler(() async {
      UserCredential credentials = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _collection.doc(credentials.user?.uid).set(
            models.User(email: email, username: username).toMap(),
          );
    });
  }

  Future<void> logout() async {
    await Helpers.globalErrorHandler(() => _auth.signOut());
  }

  Future<models.User?> getUserById() async {
    final user = await Helpers.globalErrorHandler(() async {
      final id = getUid();
      final snapshot = await _collection.doc(id).get();
      return snapshot.exists
          ? models.User.fromMap(snapshot.data()!).copy(id: id)
          : null;
    });
    return user;
  }

  String? getUid() => _auth.currentUser?.uid;
}
