// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

List<Users> UsersFromJson(String str) => List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

String  UsersToJson(List<Users> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Users {
    Users({
         this.addresse,
         this.fullnName,
        this.isActive,
         this.userEmail,
         this.userFidelParseDiscount,
         this.userId,
         this.userName,
         this.userPassword,
    });

    String addresse;
    String fullnName;
    bool  isActive;
    String userEmail;
    int  userFidelParseDiscount;
    int userId;
    String userName;
    String  userPassword;

    factory Users.fromJson(Map<dynamic, dynamic> json) => Users(
        addresse: json["Addresse"] == null ? null : json["Addresse"],
        fullnName: json["FullnName"] == null ? null : json["FullnName"],
        isActive: json["IsActive"] == null ? null : json["IsActive"],
        userEmail: json["UserEmail"] == null ? null : json["UserEmail"],
        userFidelParseDiscount: json["UserFidelParseDiscount"] == null ? null : json["UserFidelParseDiscount"],
        userId: json["UserID"] == null ? null : json["UserID"],
        userName: json["UserName"] == null ? null : json["UserName"],
        userPassword: json["UserPassword"] == null ? null : json["UserPassword"],
    );

    Map<String, dynamic> toJson() => {
        "Addresse": addresse,
        "FullnName": fullnName,
        "IsActive": isActive == null ? null : isActive,
        "UserEmail": userEmail,
        "UserFidelParseDiscount" : userFidelParseDiscount,
        "UserID":  userId,
        "UserName":  userName,
        "UserPassword":  userPassword,
    };
}
