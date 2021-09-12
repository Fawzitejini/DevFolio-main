import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:folio/users/facebook_users.dart';
import 'package:folio/users/google_users.dart';

class CustomerAvis extends StatefulWidget {
  const CustomerAvis({Key key}) : super(key: key);

  @override
  _CustomerAvisState createState() => _CustomerAvisState();
}

class _CustomerAvisState extends State<CustomerAvis> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(),
          facebookUserLogin.id == null
              ? SliverToBoxAdapter(
                  child: Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 30,
                              width: MediaQuery.of(context).size.width,
                              child: SignInButton(
                                Buttons.Google,
                                onPressed: () async {
                                  await googleUsers.signInWithGoogle();
                                  setState(() {
                                    print(facebookUserLogin.firstName);
                                  });
                                },
                                text: "Connexion par google",
                              ),
                            ),
                            Divider(
                              height: 20,
                            ),
                            SizedBox(
                              height: 30,
                              width: MediaQuery.of(context).size.width,
                              child: SignInButton(
                                Buttons.FacebookNew,
                                onPressed: () async {
                                  await LoginByFacebook.login();
                                  setState(() {});
                                },
                                text: "Connexion par facebook",
                              ),
                            )
                          ]),
                    ),
                  ),
                )
              : SliverToBoxAdapter(
                  child: Commenter(),
                )
        ],
      ),
    );
  }
}

class Commenter extends StatelessWidget {
  const Commenter({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 20,
          ),
          child: Text(
            facebookUserLogin.fullName,
            style: TextStyle(color: Colors.yellow, fontSize: 18),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          controller: comment,
          maxLines: 15,
          maxLength: 500,
          decoration: InputDecoration(
              hintMaxLines: null,
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber),
                  borderRadius: BorderRadius.circular(5)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                  borderRadius: BorderRadius.circular(5)),
              labelText: "Commentaire",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              onPressed: () async {
                Navigator.pop(context);
              },
              child: Text("Publier")),
        ),
      ],
    );
  }
}

TextEditingController comment = TextEditingController();
