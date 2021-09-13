import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_login_web/flutter_facebook_login_web.dart';
import 'package:folio/menu/bloc/repository/firebase_stock_model.dart';
import 'package:folio/public_data.dart';
import 'package:http/http.dart' as http;
import 'package:client_cookie/client_cookie.dart';

class FacebookUserLogin {
  String id;
  String fullName;
  String firstName;
  String lastName;
  String email;
  String picture;
  FacebookUserLogin(
      {this.id, this.fullName, this.firstName, this.lastName, this.email});

  factory FacebookUserLogin.fromJson(Map<String, dynamic> json) =>
      FacebookUserLogin(
        id: json['id'].toString(),
        fullName: json["name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
      );
  factory FacebookUserLogin.fromJsonFireBase(Map<String, dynamic> json) =>
      FacebookUserLogin(
        id: json['id'].toString(),
        fullName: json["fullName"],
        email: json["email"],
      );
  static Map facebookUserToMap(FacebookUserLogin usr) {
    return {
      "id": usr.id,
      "fullName": usr.fullName,
      "email": usr.email,
      "photo": usr.picture
    };
  }
}

class LoginByFacebook {
  Future<Null> logOut() async {
    await facebookSignIn.logOut();
    _showMessage('Logged out.');
  }

  static String _message = '';
  static void _showMessage(String message) {
    _message = message;
  }

  static final facebookSignIn = FacebookLoginWeb();

  static Future<Null> login(BuildContext context) async {
    final FacebookLoginResult result = await facebookSignIn.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        _showMessage('''
         Logged in!
         
         Token: ${accessToken.toMap()}
         User id: ${accessToken.userId}
         ''');
        var graphResponse = await http.get(Uri.parse(
            'https://graph.facebook.com/v2.12/me?fields=name,picture.width(800).height(800),first_name,last_name,email&access_token=${accessToken.token}'));
        var profile = json.decode(graphResponse.body);
        facebookUserLogin = FacebookUserLogin.fromJson(profile);
        setCokie(facebookUserLogin.id, facebookUserLogin.fullName,
            facebookUserLogin.email);

        facebookSignIn.testApi();
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
        break;
      case FacebookLoginStatus.cancelledByUser:
        _showMessage("Connexion annulée par l'utilisateur.");
        break;
      case FacebookLoginStatus.error:
        _showMessage('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
  }
}

FacebookUserLogin facebookUserLogin = FacebookUserLogin();

void setCokie(
  String id,
  String name,
  String email,
) {
  final idCokie = ClientCookie(id, id, DateTime.now());
  final nameCokie = ClientCookie(name, name, DateTime.now());
  final emailCokie = ClientCookie(email, email, DateTime.now());
  ClientCookie.toSetCookie([idCokie, nameCokie, emailCokie]);
}

void getCokie(String id, String name, String email) {
  try {
    final idCokie = ClientCookie(id, id, DateTime.now());
    final nameCokie = ClientCookie(name, name, DateTime.now());
    final emailCokie = ClientCookie(email, email, DateTime.now());
    if ((idCokie.name != null) &&
        (nameCokie.name != null) &&
        (emailCokie != null)) {
      facebookUserLogin.id = idCokie.value;
      facebookUserLogin.fullName = nameCokie.value;
      facebookUserLogin.email = emailCokie.value;
    }
  } catch (e) {
    print('GetCokie ' + e);
  }
}
