class Category {
	String? name;

	Category({this.name});

	factory Category.fromJson(Map<String, dynamic> json) => Category(
				name: json['name'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'name': name,
			};
}
