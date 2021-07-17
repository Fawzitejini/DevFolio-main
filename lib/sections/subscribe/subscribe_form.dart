import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:folio/menu/constants/own_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class Subscribe extends StatefulWidget {
  const Subscribe({Key key}) : super(key: key);

  @override
  _SubscribeState createState() => _SubscribeState();
}

class _SubscribeState extends State<Subscribe> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final subscribes = TextEditingController();
    String helper;

    return Container(
        child: Column(children: [
      Divider(
        height: 15,
        thickness: 1,
        color: Colors.red,
      ),
      Text(
        "\Abonnez-vous",
        style: GoogleFonts.montserrat(
          fontSize: height * 0.06,
          fontWeight: FontWeight.w100,
          letterSpacing: 1.0,
        ),
      ),
      Text(
        "Abonnez-vous pour recevoir nos actualités\n\n",
        textAlign: TextAlign.center,
        style: GoogleFonts.montserrat(fontWeight: FontWeight.w200),
      ),
      SizedBox(height: 10),
      Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column( mainAxisAlignment:MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left:10,right: 10),
               prefixIcon: Icon(Icons.mail) ,
                hintText: "Saisie votre email",
                labelText: "Email",
                helperText: SubscribeVariable.helper,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                fillColor: BrandColors.xboxGrey,
              ),
              controller: subscribes,
            ),
            SizedBox(height: 15,),
            SizedBox(
                height: 43,width:double.infinity,
                
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 1, bottom: 1, left: 5, right: 5),
                  child: ElevatedButton( style: ElevatedButton.styleFrom(primary: Colors.red,
                  side: BorderSide(color: BrandColors.xboxGrey,width: 1,style: BorderStyle.solid),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                      onPressed: () {
                        String email = subscribes.text;
                        final bool isValid = EmailValidator.validate(email);
                        if (isValid == false) {
                          SubscribeVariable.helper = "Email not valid";
                        } else {
                          SubscribeVariable.helper=null;
                        }
                        setState(() {});
                      },
                      child: Text("Click me")),
                ))
          ],
        ),
      )
    ]));
  }
}

class SubscribeVariable {
  static String helper;
}
