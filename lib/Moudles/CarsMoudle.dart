// To parse this JSON data, do
//
//     final CarsMoudle = CarsMoudleFromJson(jsonString);

import 'dart:convert';

List<CarsMoudle> CarsMoudleFromJson(String str) => List<CarsMoudle>.from(json.decode(str).map((x) => CarsMoudle.fromJson(x)));

String CarsMoudleToJson(List<CarsMoudle> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CarsMoudle {
  CarsMoudle({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
  });

  final int id;
  final String name;
  final int price;
  final String image;

  factory CarsMoudle.fromJson(Map<String, dynamic> json) => CarsMoudle(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "image": image,
  };
}
