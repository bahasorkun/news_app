// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WeatherModel {
  final String date;
  final String day;
  final String icon;
  final String description;
  final String status;
  final int degree;
  final double min;
  final double max;
  final double night;
  final int humidity;

  WeatherModel({
    required this.date,
    required this.day,
    required this.icon,
    required this.description,
    required this.status,
    required this.degree,
    required this.min,
    required this.max,
    required this.night,
    required this.humidity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date,
      'day': day,
      'icon': icon,
      'description': description,
      'status': status,
      'degree': degree,
      'min': min,
      'max': max,
      'night': night,
      'humidity': humidity,
    };
  }

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    return WeatherModel(
      date: map['date'] as String,
      day: map['day'] as String,
      icon: map['icon'] as String,
      description: map['description'] as String,
      status: map['status'] as String,
      degree: int.tryParse(map['degree'].toString()) ?? 0,
      min: double.tryParse(map['min'].toString()) ?? 0.0,
      max: double.tryParse(map['max'].toString()) ?? 0.0,
      night: double.tryParse(map['night'].toString()) ?? 0.0,
      humidity: int.tryParse(map['humidity'].toString()) ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherModel.fromJson(String source) =>
      WeatherModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
