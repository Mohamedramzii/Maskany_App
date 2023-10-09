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
    this.id,
    this.email,
    this.username,
    this.phoneNumber,
    this.image,
    this.location,
    this.dateBirth,
    this.gender,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'] as int?,
        email: json['email'] as String?,
        username: json['username'] as String?,
        phoneNumber: json['phoneNumber'] as dynamic,
        image: json['image'] as dynamic,
        location: json['location'] as dynamic,
        dateBirth: json['dateBirth'] as dynamic,
        gender: json['gender'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'username': username,
        'phoneNumber': phoneNumber,
        'image': image,
        'location': location,
        'dateBirth': dateBirth,
        'gender': gender,
      };
}
