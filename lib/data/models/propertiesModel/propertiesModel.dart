// To parse this JSON data, do
//
//     final propertiesModel = propertiesModelFromJson(jsonString);

import 'dart:convert';

List<PropertiesModel> propertiesModelFromJson(String str) => List<PropertiesModel>.from(json.decode(str).map((x) => PropertiesModel.fromJson(x)));

String propertiesModelToJson(List<PropertiesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PropertiesModel {
    List<PropImage> images;
    String title;
    Category category;
    String city;
    String locationLink;
    String details;
    DateTime createdAt;
    int space;
    int rooms;
    int bathrooms;
    int floor;
    int price;
    String phoneNumber;
    String? overlookingAt;
    String payWay;
    String lat;
    String long;

    PropertiesModel({
        required this.images,
        required this.title,
        required this.category,
        required this.city,
        required this.locationLink,
        required this.details,
        required this.createdAt,
        required this.space,
        required this.rooms,
        required this.bathrooms,
        required this.floor,
        required this.price,
        required this.phoneNumber,
        required this.overlookingAt,
        required this.payWay,
        required this.lat,
        required this.long,
    });

    factory PropertiesModel.fromJson(Map<String, dynamic> json) => PropertiesModel(
        images: List<PropImage>.from(json["images"].map((x) => PropImage.fromJson(x))),
        title: json["title"],
        category: Category.fromJson(json["category"]),
        city: json["city"],
        locationLink: json["location_link"],
        details: json["details"],
        createdAt: DateTime.parse(json["created_at"]),
        space: json["space"],
        rooms: json["rooms"],
        bathrooms: json["bathrooms"],
        floor: json["floor"],
        price: json["price"],
        phoneNumber: json["phone_number"],
        overlookingAt: json["overlooking_at"],
        payWay: json["pay_way"],
        lat: json["lat"],
        long: json["long"],
    );

    Map<String, dynamic> toJson() => {
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "title": title,
        "category": category.toJson(),
        "city": city,
        "location_link": locationLink,
        "details": details,
        "created_at": "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
        "space": space,
        "rooms": rooms,
        "bathrooms": bathrooms,
        "floor": floor,
        "price": price,
        "phone_number": phoneNumber,
        "overlooking_at": overlookingAt,
        "pay_way": payWay,
        "lat": lat,
        "long": long,
    };
}

class Category {
    String name;

    Category({
        required this.name,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}

class PropImage {
    String image;

    PropImage({
        required this.image,
    });

    factory PropImage.fromJson(Map<String, dynamic> json) => PropImage(
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "image": image,
    };
}
