// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WeatherModel {
  final String date;
  final String day;
  final String icon;
  final String description;
  final String status;
  final String degree;
  final String min;
  final String max;
  final String night;
  final String humidity;

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
      date: map['date'] ?? " ",
      day: map['day'] ?? " ",
      icon: map['icon'] ?? " ",
      description: map['description'] ?? " ",
      status: map['status'] ?? " ",
      degree: map['degree'] ?? " ",
      min: map['min'] ?? " ",
      max: map['max'] ?? " ",
      night: map['night'] ?? " ",
      humidity: map['humidity'] ?? " ",
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherModel.fromJson(String source) =>
      WeatherModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
