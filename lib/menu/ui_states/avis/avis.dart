import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:folio/menu/bloc/repository/firebase_stock_model.dart';
import 'package:folio/menu/bloc/repository/setstock.dart';
import 'package:folio/public_data.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed("ourmenu");
                            },
                            icon: Icon(Icons.arrow_back)),
                      ]),
                ),
              ),
            ),
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
                                    await googleUsers.signInWithGoogle(context);
                                    setState(() {});
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
                                    await LoginByFacebook.login(context);
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
        SizedBox(
          height: 20,
        ),
        _Rating(),
        TextField(
          controller: ratingComment,
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
                try {
                  if (avisEditing == false) {
                    FAvis _avis = FAvis(
                        key: currentavis.key,
                        comment: ratingComment.text,
                        rate: ratingController,
                        user: facebookUserLogin);
                    await SetData.setNewAvis(globalStock, _avis);
                    Navigator.of(context).pushReplacementNamed("ourmenu");
                  } else {
                      
                    FAvis _avis = FAvis(
                         key: currentavis.key,
                        comment: ratingComment.text,
                        rate: ratingController,
                        user: facebookUserLogin);
                  await  SetData.editAvis(globalStock, _avis);
                    Navigator.of(context).pushReplacementNamed("ourmenu");
                  }
                } catch (e) {
                  print("An error in : " +e);
                }
              },
              child: Text("Publier")),
        ),
      ],
    );
  }
}

TextEditingController ratingComment = TextEditingController();
double ratingController = 1;

class _Rating extends StatelessWidget {
  const _Rating({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: ratingController,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        ratingController = rating;
      },
    );
  }
}










FAvis currentavis =FAvis();