// ignore_for_file: prefer_const_constructors
// import 'dart:ffi';
import 'package:flutter/material.dart';
import 'dart:convert';

class Productmodel {
  List<Product> products;
  int total;
  int skip;
  int limit;

  Productmodel(
      {required this.products,
      required this.limit,
      required this.skip,
      required this.total});

  factory Productmodel.fromMap(Map<String, dynamic> json) => Productmodel(
      products:
          List<Product>.from(json["products"].map((x) => Product.fromMap(x))),
      limit: json["limit"],
      skip: json["skip"],
      total: json["total"]);

  Map<String, dynamic> toMap() => {
        "products": List<dynamic>.from(products.map((x) => x.toMap())),
        "total": total,
        "skip": skip,
        "limit": limit,
      };
}

class Product {
  int id;
  String title;
  String category;
  double price;
  int stock;
  String sku;
  String thumbnail;

  Product(
      {required this.id,
      required this.title,
      required this.category,
      required this.price,
      required this.stock,
      required this.sku,
      required this.thumbnail});

  factory Product.fromMap(Map<String, dynamic> json) => Product(
      id: json["id"],
      title: json["title"],
      category: json["category"],
      price: json["price"],
      stock: json["stock"],
      sku: json["sku"],
      thumbnail: json["thumbnail"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "category": category,
        "price": price,
        "stock": stock,
        "sku": sku,
        "thumbnail": thumbnail
      };
}
