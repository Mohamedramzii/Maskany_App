// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

// Dart imports:
import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    String? type;
    String ?detail;
    int? id;
    Data? data;
    String? token;

    LoginModel({
        required this.type,
        required this.detail,
        required this.id,
        required this.data,
        required this.token,
    });

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        type: json["type"],
        detail: json["detail"],
        id: json["id"] ?? null,
        data: Data.fromJson(json["data"]),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "detail": detail,
        "id": id,
        "data": data?.toJson(),
        "token": token,
    };
}

class Data {
    int? id;
    String? email;
    String? username;
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
