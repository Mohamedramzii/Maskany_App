// To parse this JSON data, do
//
//     final propertiesModel3 = propertiesModel3FromJson(jsonString);

import 'dart:convert';

PropertiesModel3 propertiesModel3FromJson(String str) =>
    PropertiesModel3.fromJson(json.decode(str));

String propertiesModel3ToJson(PropertiesModel3 data) =>
    json.encode(data.toJson());

class PropertiesModel3 {
  List<Result>? results;

  PropertiesModel3({
    this.results,
  });

  factory PropertiesModel3.fromJson(Map<String, dynamic> json) =>
      PropertiesModel3(
        results: json["results"] == null
            ? []
            : List<Result>.from(
                json["results"]!.map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Result {
  int? id;
  List<Image>? images;
  String? title;
  Category? category;
  String? city;
  String? locationLink;
  String? details;
  DateTime? createdAt;
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
  bool? isSeen;
  bool? rent;

  Result({
    this.id,
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
    this.isSeen,
    this.rent,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        images: json["images"] == null
            ? []
            : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
        title: json["title"],
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        city: json["city"],
        locationLink: json["location_link"],
        details: json["details"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
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
        isSeen: json["is_seen"],
        rent: json["rent"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "images": images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
        "title": title,
        "category": category?.toJson(),
        "city": city,
        "location_link": locationLink,
        "details": details,
        "created_at":
            "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
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
        "is_seen": isSeen,
        "rent": rent,
      };
}

class Category {
  int? id;
  String? name;

  Category({
    this.id,
    this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Image {
  String? image;

  Image({
    this.image,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
      };
}
