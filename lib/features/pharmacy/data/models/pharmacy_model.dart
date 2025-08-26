// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PharmacyModel {
  final String name;
  final String dist;
  final String address;
  final String phone;
  final String loc;

  PharmacyModel({
    required this.name,
    required this.dist,
    required this.address,
    required this.phone,
    required this.loc,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'dist': dist,
      'address': address,
      'phone': phone,
      'loc': loc,
    };
  }

  factory PharmacyModel.fromMap(Map<String, dynamic> map) {
    return PharmacyModel(
      name: (map['name'] ?? '').toString(),
      dist: (map['dist'] ?? '').toString(),
      address: (map['address'] ?? '').toString(),
      phone: (map['phone'] ?? '').toString(),
      loc: (map['loc'] ?? '').toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PharmacyModel.fromJson(String source) =>
      PharmacyModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
