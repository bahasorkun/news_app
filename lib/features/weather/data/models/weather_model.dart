// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WeatherModel {
  final String date;
  final String day;
  final String icon;
  final String description;
  final String status;
  final double degree;
  final double min;
  final double max;
  final double night;
  final double humidity;

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

  factory WeatherModel.fromMap(Map<String, dynamic> j) {
    double d(v) =>
        v is num ? v.toDouble() : double.tryParse(v?.toString() ?? '') ?? 0.0;

    return WeatherModel(
      date: (j['date'] ?? '').toString(),
      day: (j['day'] ?? '').toString(),
      icon: (j['icon'] ?? '').toString(),
      description: (j['description'] ?? '').toString(),
      status: (j['status'] ?? '').toString(),
      degree: d(j['degree']),
      min: d(j['min']),
      max: d(j['max']),
      night: d(j['night']),
      humidity: d(j['humidity']),
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherModel.fromJson(String source) =>
      WeatherModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
