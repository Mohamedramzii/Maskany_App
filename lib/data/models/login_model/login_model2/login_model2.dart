// Project imports:
import 'data.dart';

class LoginModel2 {
	String? type;
	String? detail;
	int? id;
	Data? data;
	String? token;

	LoginModel2({this.type, this.detail, this.id, this.data, this.token});

	factory LoginModel2.fromJson(Map<String, dynamic> json) => LoginModel2(
				type: json['type'] as String?,
				detail: json['detail'] as String?,
				id: json['id'] as int?,
				data: json['data'] == null
						? null
						: Data.fromJson(json['data'] as Map<String, dynamic>),
				token: json['token'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'type': type,
				'detail': detail,
				'id': id,
				'data': data?.toJson(),
				'token': token,
			};
}
