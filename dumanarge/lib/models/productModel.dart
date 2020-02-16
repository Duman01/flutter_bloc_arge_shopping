
// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';
import 'dart:math';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

Random random = new Random();

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductList{
  final List<Product> listProduct;
  ProductList({this.listProduct});

  factory ProductList.fromJson(List<dynamic> json){
    List<Product> listProduct = new List<Product>();
    listProduct = json.map((i)=>Product.fromJson(i)).toList();
    return ProductList(listProduct: listProduct);
  }

  Map<String, dynamic> toJson() => {
    "listProduct" : List<dynamic>.from(listProduct.map((f)=>f.toJson())),
  };
}


class Product {
    int albumId;
    int id;
    String title;
    String url;
    String thumbnailUrl;
    int price;

    GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

    Product({
        this.albumId,
        this.id,
        this.title,
        this.url,
        this.thumbnailUrl,
        this.price,
        this.cardKey
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        albumId: json["albumId"],
        id: json["id"],
        title: json["title"],
        url: json["url"],
        thumbnailUrl: json["thumbnailUrl"],
        price: json['id']*10,
        cardKey: GlobalKey<FlipCardState>(),
    );

    Map<String, dynamic> toJson() => {
        "albumId": albumId,
        "id": id,
        "title": title,
        "url": url,
        "thumbnailUrl": thumbnailUrl,
        "price": price
    };
}

