import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:folio/menu/bloc/repository/firebase_stock_model.dart';
import 'package:folio/users/facebook_users.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../public_data.dart';

class UserAuth {
  static void googleAuth() {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String uid;
  String userEmail;
  Future<User> registerWithEmailPassword(String email, String password) async {
    // Initialize Firebase
    await Firebase.initializeApp();
    User user;

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      user = userCredential.user;

      if (user != null) {
        uid = user.uid;
        userEmail = user.email;
      }
    } catch (e) {
      print(e);
    }

    return user;
  }
}

class Users {
  String uid;
  String userEmail;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String name;
  String imageUrl;
  Future<void> signInWithGoogle(BuildContext context) async {
    // Initialize Firebase
    await Firebase.initializeApp();
    User user;

    GoogleAuthProvider authProvider = GoogleAuthProvider();

    try {
      final UserCredential userCredential =
          await _auth.signInWithPopup(authProvider);
      user = userCredential.user;
    } catch (e) {
      print(e);
    }

    if (user != null) {
      facebookUserLogin.id = user.uid;
      facebookUserLogin.fullName = user.displayName;
      facebookUserLogin.email = user.email;
        bool isDone = false;
        await CurrentItemAvis.listOfAvis(globalStock).then((value) {
          var m =
              value.where((element) => element.user.id == facebookUserLogin.id);
          if (m.length > 0) {
            isDone = true;
          } else {
            isDone = false;
          }
        });
        if (isDone==true){Navigator.of(context).pushReplacementNamed("ourmenu");}
   //   googleUser.imageUrl = user.photoURL;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('auth', true);
    }


  }
}

Users googleUsers =Users();

bool checkUser() {
  if  (facebookUserLogin.fullName == null) {
    return false;
  } else {
    return true;
  }
}




