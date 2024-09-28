import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app_flutter/data/models/user.dart' as model;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserRepo {
  static final UserRepo _instance = UserRepo._init();
  factory UserRepo() => _instance;
  UserRepo._init();

  final _collection = FirebaseFirestore.instance.collection("users");
  final _auth = FirebaseAuth.instance;

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
    }
  }

  Future<void> register(String username, String email, String password,
      String confirmPassword) async {
    try {
      final model.User user = model.User(email: email, username: username);
      UserCredential credentials = await _auth.createUserWithEmailAndPassword(
          email: user.email, password: password);
      await _collection.doc(credentials.user?.uid).set(user.toMap());
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
    }
  }

  String? getUid() => _auth.currentUser?.uid;
}
