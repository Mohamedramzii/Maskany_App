// Project imports:
import 'property.dart';

class AdsModel {
	int? rank;
	Property? property;

	AdsModel({this.rank, this.property});

	factory AdsModel.fromJson(Map<String, dynamic> json) => AdsModel(
				rank: json['rank'] as int?,
				property: json['property'] == null
						? null
						: Property.fromJson(json['property'] as Map<String, dynamic>),
			);

	Map<String, dynamic> toJson() => {
				'rank': rank,
				'property': property?.toJson(),
			};
}
