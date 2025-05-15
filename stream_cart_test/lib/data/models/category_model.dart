import 'package:flutter/material.dart';

class CategoryModel {
  final String id;
  final String name;
  final IconData iconData;
  final String? imageUrl;

  CategoryModel({
    required this.id,
    required this.name,
    required this.iconData,
    this.imageUrl,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'].toString(),
      name: json['name'] as String,
      iconData: IconData(json['icon_code'] as int, fontFamily: 'MaterialIcons'),
      imageUrl: json['image_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon_code': iconData.codePoint,
      'image_url': imageUrl,
    };
  }
}