import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app_flutter/data/models/restaurant.dart';
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

//Favourite Methods-------------------------------------------------------------

  Stream<List<Restaurant>> getUserFavourites() =>
      _collection.doc(getUid()!).snapshots().map(
            (snapshot) => snapshot.exists
                ? List<Restaurant>.from(
                    models.User.fromMap(snapshot.data()!).favourites,
                  )
                : [],
          );

  Future<models.User?> getUserInfo() async {
    final snapshot = await _collection.doc(getUid()!).get();
    return snapshot.exists ? models.User.fromMap(snapshot.data()!) : null;
  }

  Future<Restaurant?> getUserFavouriteById(String id) async {
    final favourite = await Helpers.globalErrorHandler(() async {
      final snapshot = await _collection.doc(getUid()!).get();
      if (!snapshot.exists) return null;
      final favourites = models.User.fromMap(snapshot.data()!).favourites;
      return favourites.where((favourite) => favourite.id == id).isNotEmpty
          ? favourites.singleWhere((favourite) => favourite.id == id)
          : null;
    });
    return favourite;
  }

  Future<void> updateUserFavourites(Restaurant favourite) async {
    final user = await getUserInfo();
    if (user == null) return;
    final favourites = user.favourites;
    if (favourites.contains(favourite)) {
      favourites.remove(favourite);
    } else {
      favourites.add(favourite);
    }
    _collection.doc(getUid()!).set(user.copy(favourites: favourites).toMap());
  }

//Favourite Methods-------------------------------------------------------------
}
