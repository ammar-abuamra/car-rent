// To parse this JSON data, do
//
//     final avalibaleCarMoudle = avalibaleCarMoudleFromJson(jsonString);

import 'dart:convert';



class AvalibaleCarMoudle {
  AvalibaleCarMoudle({
    required this.status,
    required this.error,
    required  this.count,
    required  this.overlaps,
    required   this.data,
  });

  final String status;
  final String error;
  final int count;
  final int overlaps;
  final Map<String, Datum> data;

  factory AvalibaleCarMoudle.fromJson(Map<String, dynamic> json) => AvalibaleCarMoudle(
    status: json["status"],
    error: json["error"],
    count: json["count"],
    overlaps: json["overlaps"],
    data: Map.from(json["data"]).map((k, v) => MapEntry<String, Datum>(k, Datum.fromJson(v))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "error": error,
    "count": count,
    "overlaps": overlaps,
    "data": Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
  };
}

class Datum {
  Datum({
    required  this.name,
    required  this.price,
    required  this.image,
  });

  final String name;
  final int price;
  final String image;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    name: json["name"],
    price: json["price"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "price": price,
    "image": image,
  };
}
