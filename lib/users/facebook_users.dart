import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_login_web/flutter_facebook_login_web.dart';
import 'package:http/http.dart' as http;
import 'package:client_cookie/client_cookie.dart';

class MyApp2 extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp2> {
  String _message = '';
  static final facebookSignIn = FacebookLoginWeb();

  Future<Null> _login() async {
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
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${accessToken.token}'));
        var profile = json.decode(graphResponse.body);
        print(profile);
        facebookUserLogin = FacebookUserLogin.fromJson(profile);
        setCokie(facebookUserLogin.id, facebookUserLogin.fullName,
            facebookUserLogin.email);

        facebookSignIn.testApi();
        facebookSignIn.testApi();

        break;
      case FacebookLoginStatus.cancelledByUser:
        _showMessage('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        _showMessage('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
  }

  Future<Null> _logOut() async {
    await facebookSignIn.logOut();
    _showMessage('Logged out.');
  }

  void _showMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text(_message),
              RaisedButton(
                onPressed: _login,
                child: Text("Login with Facebook"),
              ),
              RaisedButton(
                onPressed: _logOut,
                child: Text("Logout"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FacebookUserLogin {
  String id;
  String fullName;
  String firstName;
  String lastName;
  String email;
  FacebookUserLogin(
      {this.id, this.fullName, this.firstName, this.lastName, this.email});

  factory FacebookUserLogin.fromJson(Map<String, dynamic> json) =>
      FacebookUserLogin(
        id: json['id'],
        fullName: json["name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
      );
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

  static Future<Null> login() async {
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
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${accessToken.token}'));
        var profile = json.decode(graphResponse.body);
        facebookUserLogin = FacebookUserLogin.fromJson(profile);
        setCokie(facebookUserLogin.id, facebookUserLogin.fullName,
            facebookUserLogin.email);

        facebookSignIn.testApi();
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
