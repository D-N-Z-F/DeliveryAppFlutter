import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app_flutter/data/models/restaurant.dart';
import 'package:delivery_app_flutter/data/models/user.dart' as models;
import 'package:delivery_app_flutter/main.dart';
import 'package:delivery_app_flutter/utils/constants/colors.dart';
import 'package:delivery_app_flutter/utils/constants/enums.dart';
import 'package:delivery_app_flutter/utils/helpers/helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserRepo {
  static final UserRepo _instance = UserRepo._init();
  factory UserRepo() => _instance;
  UserRepo._init();

  final _collection = FirebaseFirestore.instance.collection("users");
  final _auth = FirebaseAuth.instance;

  Future<void> login(String email, String password) async =>
      await Helpers.globalErrorHandler(
        () async {
          await _auth.signInWithEmailAndPassword(
            email: email,
            password: password,
          );
          MyApp.showSnackBar(
            content: "Login successful.",
            theme: SnackBarTheme.success,
            color: MyColors.success,
          );
        },
      );

  Future<void> register(
    String username,
    String email,
    String password,
    String confirmPassword,
  ) async {
    await Helpers.globalErrorHandler(() async {
      UserCredential credentials = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _collection.doc(credentials.user?.uid).set(
            models.User(email: email, username: username).toMap(),
          );
      MyApp.showSnackBar(
        content: "Registration successful.",
        theme: SnackBarTheme.success,
        color: MyColors.success,
      );
    });
  }

  Future<void> logout() async => await Helpers.globalErrorHandler(
        () async {
          await _auth.signOut();
          MyApp.showSnackBar(
            content: "Logout successful.",
            theme: SnackBarTheme.success,
            color: MyColors.success,
          );
        },
      );

  Future<models.User?> getUserById() async {
    final user = await Helpers.globalErrorHandler(
      () async {
        final id = getUid();
        final snapshot = await _collection.doc(id).get();
        return snapshot.exists
            ? models.User.fromMap(snapshot.data()!).copy(id: id)
            : null;
      },
    );
    return user;
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

  Future<bool> updateUserDetails(
    String username,
    String email,
    String password,
  ) async {
    final update = await Helpers.globalErrorHandler(
      () async {
        final user = await getUserById();
        final firebaseUser = FirebaseAuth.instance.currentUser;
        if (user != null && firebaseUser != null) {
          await firebaseUser.reauthenticateWithCredential(
            EmailAuthProvider.credential(
              email: firebaseUser.email!,
              password: password,
            ),
          );
          await firebaseUser.verifyBeforeUpdateEmail(email);
          await firebaseUser.reload();
          await _collection
              .doc(user.id)
              .set(user.copy(username: username, email: email).toMap());
          MyApp.showSnackBar(
            content: "User details updated.",
            theme: SnackBarTheme.success,
            seconds: 2,
          );
          return true;
        }
      },
    );
    return update ?? false;
  }

  Future<bool> updatePassword(String password) async {
    final update = await Helpers.globalErrorHandler(
      () async {
        final firebaseUser = FirebaseAuth.instance.currentUser;
        debugPrint(firebaseUser.toString());
        if (firebaseUser != null) {
          await firebaseUser.updatePassword(password);
          await firebaseUser.reload();
          MyApp.showSnackBar(
            content: "Password details updated.",
            theme: SnackBarTheme.success,
            seconds: 2,
          );
          return true;
        }
      },
    );
    return update ?? false;
  }

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
    final favourite = await Helpers.globalErrorHandler(
      () async {
        final snapshot = await _collection.doc(getUid()!).get();
        if (!snapshot.exists) return null;
        final favourites = models.User.fromMap(snapshot.data()!).favourites;
        return favourites.where((favourite) => favourite.id == id).isNotEmpty
            ? favourites.singleWhere((favourite) => favourite.id == id)
            : null;
      },
    );
    return favourite;
  }

  Future<void> updateUserFavourites(Restaurant favourite) async =>
      await Helpers.globalErrorHandler(
        () async {
          final user = await getUserInfo();
          if (user == null) return;
          final favourites = user.favourites;
          if (favourites.contains(favourite)) {
            favourites.remove(favourite);
          } else {
            favourites.add(favourite);
          }
          await _collection
              .doc(getUid()!)
              .set(user.copy(favourites: favourites).toMap());
          MyApp.showSnackBar(content: "Updated favourites.", seconds: 1);
        },
      );

//Favourite Methods-------------------------------------------------------------
}
