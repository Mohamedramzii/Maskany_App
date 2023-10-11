class UserDataModel {
	String? email;
	String? image;
	String? username;
	String? phoneNumber;
	dynamic dateBirth;
	String? location;
	String? gender;

	UserDataModel({
		this.email, 
		this.image, 
		this.username, 
		this.phoneNumber, 
		this.dateBirth, 
		this.location, 
		this.gender, 
	});

	factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
				email: json['email'] as String?,
				image: json['image'] as String?,
				username: json['username'] as String?,
				phoneNumber: json['phoneNumber'] as String?,
				dateBirth: json['dateBirth'] as dynamic,
				location: json['location'] as String?,
				gender: json['gender'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'email': email,
				'image': image,
				'username': username,
				'phoneNumber': phoneNumber,
				'dateBirth': dateBirth,
				'location': location,
				'gender': gender,
			};
}
