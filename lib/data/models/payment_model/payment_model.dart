// Project imports:
import 'subscription_data.dart';

class PaymentModel {
	String? type;
	String? url;
	SubscriptionData? subscriptionData;

	PaymentModel({this.type, this.url, this.subscriptionData});

	factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
				type: json['type'] as String?,
				url: json['url'] as String?,
				subscriptionData: json['subscription_data'] == null
						? null
						: SubscriptionData.fromJson(json['subscription_data'] as Map<String, dynamic>),
			);

	Map<String, dynamic> toJson() => {
				'type': type,
				'url': url,
				'subscription_data': subscriptionData?.toJson(),
			};
}
