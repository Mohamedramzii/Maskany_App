import 'data.dart';

class RegisterModel {
  String? detail;
  Data? data;
  String? token;

  RegisterModel({this.detail, this.data, this.token});

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        detail: json['detail'] as String?,
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
        token: json['token'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'detail': detail,
        'data': data?.toJson(),
        'token': token,
      };
}
