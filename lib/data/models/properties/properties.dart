// Project imports:
import 'category.dart';
import 'image.dart';

class Properties {
  List<Image>? images;
  String? title;
  Category? category;
  String? city;
  String? locationLink;
  String? details;
  String? createdAt;
  int? space;
  int? rooms;
  int? bathrooms;
  int? floor;
  int? price;
  String? phoneNumber;
  String? overlookingAt;
  String? payWay;
  String? lat;
  String? long;

  Properties({
    this.images,
    this.title,
    this.category,
    this.city,
    this.locationLink,
    this.details,
    this.createdAt,
    this.space,
    this.rooms,
    this.bathrooms,
    this.floor,
    this.price,
    this.phoneNumber,
    this.overlookingAt,
    this.payWay,
    this.lat,
    this.long,
  });

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        images: (json['images'] as List<dynamic>?)
            ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
            .toList(),
        title: json['title'] as String?,
        category: json['category'] == null
            ? null
            : Category.fromJson(json['category']),
        city: json['city'] as String?,
        locationLink: json['location_link'] as String?,
        details: json['details'] as String?,
        createdAt: json['created_at'] as String?,
        space: json['space'] as int?,
        rooms: json['rooms'] as int?,
        bathrooms: json['bathrooms'] as int?,
        floor: json['floor'] as int?,
        price: json['price'] as int?,
        phoneNumber: json['phone_number'] as String?,
        overlookingAt: json['overlooking_at'] as String?,
        payWay: json['pay_way'] as String?,
        lat: json['lat'] as String?,
        long: json['long'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'images': images?.map((e) => e.toJson()).toList(),
        'title': title,
        'category': category?.toJson(),
        'city': city,
        'location_link': locationLink,
        'details': details,
        'created_at': createdAt,
        'space': space,
        'rooms': rooms,
        'bathrooms': bathrooms,
        'floor': floor,
        'price': price,
        'phone_number': phoneNumber,
        'overlooking_at': overlookingAt,
        'pay_way': payWay,
        'lat': lat,
        'long': long,
      };
}
