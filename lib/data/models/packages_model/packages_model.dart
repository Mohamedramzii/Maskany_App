class PackagesModel {
	int? id;
	bool? isUserSubscribed;
	List<dynamic>? packageFeatures;
	String? name;
	int? duration;
	int? price;
	int? adsNumber;

	PackagesModel({
		this.id, 
		this.isUserSubscribed, 
		this.packageFeatures, 
		this.name, 
		this.duration, 
		this.price, 
		this.adsNumber, 
	});

	factory PackagesModel.fromJson(Map<String, dynamic> json) => PackagesModel(
				id: json['id'] as int?,
				isUserSubscribed: json['is_user_subscribed'] as bool?,
				packageFeatures: json['package_features'] as List<dynamic>?,
				name: json['name'] as String?,
				duration: json['duration'] as int?,
				price: json['price'] as int?,
				adsNumber: json['ads_number'] as int?,
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'is_user_subscribed': isUserSubscribed,
				'package_features': packageFeatures,
				'name': name,
				'duration': duration,
				'price': price,
				'ads_number': adsNumber,
			};
}
