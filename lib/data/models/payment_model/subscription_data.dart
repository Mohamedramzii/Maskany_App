class SubscriptionData {
	int? id;
	int? package;
	int? user;
	bool? active;
	bool? isPaied;

	SubscriptionData({
		this.id, 
		this.package, 
		this.user, 
		this.active, 
		this.isPaied, 
	});

	factory SubscriptionData.fromJson(Map<String, dynamic> json) {
		return SubscriptionData(
			id: json['id'] as int?,
			package: json['package'] as int?,
			user: json['user'] as int?,
			active: json['active'] as bool?,
			isPaied: json['is_paied'] as bool?,
		);
	}



	Map<String, dynamic> toJson() => {
				'id': id,
				'package': package,
				'user': user,
				'active': active,
				'is_paied': isPaied,
			};
}
