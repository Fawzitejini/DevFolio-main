import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:folio/admin/screens/dashboard/dashboard_screen.dart';
import 'package:folio/constants.dart';
import 'package:folio/menu/constants/own_colors.dart';
import 'package:flutter_login/flutter_login.dart';
import '../../main_admin.dart';


class LoginForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final paddingTopForm, fontSizeTextField, fontSizeTextFormField, spaceBetweenFields, iconFormSize;
  final spaceBetweenFieldAndButton, widthButton, fontSizeButton, fontSizeForgotPassword, fontSizeSnackBar, errorFormMessage;

  LoginForm(
    this.paddingTopForm, this.fontSizeTextField, this.fontSizeTextFormField, this.spaceBetweenFields, this.iconFormSize, this.spaceBetweenFieldAndButton,
    this.widthButton, this.fontSizeButton, this.fontSizeForgotPassword, this.fontSizeSnackBar, this.errorFormMessage
  );

  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;
    final double heightSize = MediaQuery.of(context).size.height; 
    
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.only(left: widthSize * 0.05, right: widthSize * 0.05, top: heightSize * paddingTopForm),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Nom d'utilisateur", style: TextStyle(
                fontSize: widthSize * fontSizeTextField,
                fontFamily: 'Poppins',
                color: Colors.white)
              )
            ),
            TextFormField(
              controller: _usernameController,
              // ignore: missing_return
              validator: (value) {
                if(value.isEmpty) {
                  return "Entrez votre nom d'utilisateur pour continuer !";
                }
              },
              cursorColor: Colors.white,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                fillColor: Colors.white,
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2)
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2)
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2)
                ),
                labelStyle: TextStyle(color: Colors.white),
                errorStyle: TextStyle(color: Colors.white, fontSize: widthSize * errorFormMessage),
                prefixIcon: Icon(
                  Icons.person,
                  size: widthSize * iconFormSize,
                  color: Colors.white,
                ),
              ),
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.white, fontSize: fontSizeTextFormField)
            ),
            SizedBox(height: heightSize * spaceBetweenFields),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Mot de passe', style: TextStyle(
                fontSize: widthSize * fontSizeTextField,
                fontFamily: 'Poppins',
                color: Colors.white)
              )
            ),
            TextFormField(
              controller: _passwordController,
              // ignore: missing_return
              validator: (value) {
                if(value.isEmpty) {
                  return 'Entrez votre mot de passe pour continuer !';
                }
              },
              cursorColor: Colors.white,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                fillColor: Colors.white,
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2)
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2)
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2)
                ),
                labelStyle: TextStyle(color: Colors.white),
                errorStyle: TextStyle(color: Colors.white, fontSize: widthSize * errorFormMessage),
                prefixIcon: Icon(
                  Icons.lock,
                  size: widthSize * iconFormSize,
                  color: Colors.white,
                ),
              ),
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.white, fontSize: fontSizeTextFormField)
            ),
            SizedBox(height: heightSize * spaceBetweenFieldAndButton),
            // ignore: deprecated_member_use
           SizedBox(height:30,width: MediaQuery.of(context).size.width/3,
             child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                            primary: Colors.grey,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                onPressed: () async {
                  if(_formKey.currentState.validate()) {
                    
                  }
                },
                child: Text('ENTRER', style: TextStyle(
                  fontSize:18,
                  fontFamily: 'Poppins',
                  color: Colors.white)
                )
              ),
           ),
            SizedBox(height: heightSize * 0.01),
            Text("j'ai oublié mon mot de passe", style: TextStyle(
              fontSize: widthSize * fontSizeForgotPassword,
              fontFamily: 'Poppins',
              color: Colors.white)
            )
          ]
        )
      )
    );
  }
}














const users = const {
  'fouzi@gmail.com': '12345',
  'info@flutter.dev': 'flutter',
};

class LoginScreen extends StatelessWidget {
   Duration get loginTime => Duration(milliseconds: 2250);

  Future<String> _authUser(LoginData data) {
    print('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return "L'utilisateur n'existe pas";
      }
      if (users[data.name] != data.password) {
        return 'Le mot de passe ne correspond pas';
      }
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return "L'utilisateur n'existe pas";
      }
      return null;
    });
  }
  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      hideSignUpButton: true,
      title: "Administration",
      logo: 'assets/images/logo.png',
      
      onLogin: _authUser,
      onSignup: _authUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacementNamed("adminpanel");
      },
      onRecoverPassword: (_) => Future(null),
      messages: LoginMessages(
        userHint: 'Utilisateur',
        passwordHint: 'Mot de passe',
        confirmPasswordHint: 'Confirm',
        loginButton: 'Connexion',
        signupButton: 'REGISTER',
        forgotPasswordButton: 'Mot de passe oublier?',
        recoverPasswordButton: 'Aide moi',
        goBackButton: 'Retour',
        confirmPasswordError: 'Incorrect!',
        recoverPasswordDescription:
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
        recoverPasswordSuccess: 'Password rescued successfully',
      ),
    );
  }
}







class Admin
{

}