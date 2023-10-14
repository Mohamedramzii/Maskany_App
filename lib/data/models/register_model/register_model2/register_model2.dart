import 'data.dart';

class RegisterModel2 {
  // String? type;
  String? detail;
  Data? data;
  String? token;

  RegisterModel2({
    // this.type,
    this.detail,
    this.data,
    this.token,
  });

  factory RegisterModel2.fromJson(Map<String, dynamic> json) {
    return RegisterModel2(
      // type: json['type'] as String?,
      detail: json['detail'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        // 'type': type,
        'detail': detail,
        'data': data?.toJson(),
        'token': token,
      };
}
