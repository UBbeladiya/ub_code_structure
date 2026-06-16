// To parse this JSON data, do
//
//     final ProductModel = productModelFromJson(jsonString);

import 'dart:convert';
//product
List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  final int? userId;
  final int? id;
  final String? title;
  final String? body;

  ProductModel({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
    body: json["body"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "id": id,
    "title": title,
    "body": body,
  };
}
