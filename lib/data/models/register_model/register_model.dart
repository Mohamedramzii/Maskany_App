// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

RegisterModel registerModelFromJson(String str) => RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
    String type;
    String detail;
    Data data;
    String token;

    RegisterModel({
        required this.type,
        required this.detail,
        required this.data,
        required this.token,
    });

    factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        type: json["type"],
        detail: json["detail"],
        data: Data.fromJson(json["data"]),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "detail": detail,
        "data": data.toJson(),
        "token": token,
    };
}

class Data {
    int id;
    String email;
    String username;
    dynamic phoneNumber;
    dynamic image;
    dynamic location;
    dynamic dateBirth;
    dynamic gender;

    Data({
        required this.id,
        required this.email,
        required this.username,
        required this.phoneNumber,
        required this.image,
        required this.location,
        required this.dateBirth,
        required this.gender,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        email: json["email"],
        username: json["username"],
        phoneNumber: json["phoneNumber"],
        image: json["image"],
        location: json["location"],
        dateBirth: json["dateBirth"],
        gender: json["gender"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "username": username,
        "phoneNumber": phoneNumber,
        "image": image,
        "location": location,
        "dateBirth": dateBirth,
        "gender": gender,
    };
}
