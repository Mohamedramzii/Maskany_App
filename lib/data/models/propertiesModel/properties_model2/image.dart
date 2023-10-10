class Image {
	String? image;

	Image({this.image});

	factory Image.fromJson(Map<String, dynamic> json) => Image(
				image: json['image'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'image': image,
			};
}
