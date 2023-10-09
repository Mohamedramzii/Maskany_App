class CategoriesModel {
	int? id;
	String? name;

	CategoriesModel({this.id, this.name});

	factory CategoriesModel.fromJson(Map<String, dynamic> json) {
		return CategoriesModel(
			id: json['id'] as int?,
			name: json['name'] as String?,
		);
	}



	Map<String, dynamic> toJson() => {
				'id': id,
				'name': name,
			};
}
