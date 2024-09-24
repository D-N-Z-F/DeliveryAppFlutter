import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepo {
  static final UserRepo _instance = UserRepo._init();
  factory UserRepo() => _instance;
  UserRepo._init();

  final _collection = FirebaseFirestore.instance.collection("users");

  Future<void> login() async {}

  Future<void> register() async {}

  Future<void> updateUser() async {}

  Future<void> deleteUser() async {}
}
