// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:cuidapet/app/models/supplier_categories_model.dart';

class SupplierModel {
  final int id;
  final String name;
  final String logo;
  final String address;
  final String phone;
  final double latitude;
  final double longitude;
  final SupplierCategoryModel category;

  SupplierModel({
    required this.id,
    required this.name,
    required this.logo,
    required this.address,
    required this.phone,
    required this.latitude,
    required this.longitude,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'logo': logo,
      'address': address,
      'phone': phone,
      'latitude': latitude,
      'longitude': longitude,
      'category': category.toMap(),
    };
  }

  factory SupplierModel.fromMap(Map<String, dynamic> map) {
    return SupplierModel(
      id: (map['id'] ?? 0) as int,
      name: (map['name'] ?? '') as String,
      logo: (map['logo'] ?? '') as String,
      address: (map['address'] ?? '') as String,
      phone: (map['phone'] ?? '') as String,
      latitude: (map['latitude'] ?? 0.0) as double,
      longitude: (map['longitude'] ?? 0.0) as double,
      category: SupplierCategoryModel.fromMap(
          map['category'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory SupplierModel.fromJson(String source) =>
      SupplierModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
