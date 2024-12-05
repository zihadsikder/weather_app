import 'dart:convert';

import 'package:hive/hive.dart';

part 'weather_model.g.dart';

@HiveType(typeId: 0)
class WeatherModel {
  @HiveField(0)
  String? name;

  @HiveField(1)
  double? temp;

  @HiveField(2)
  double? tempMin;

  @HiveField(3)
  double? tempMax;

  @HiveField(4)
  String? description;

  @HiveField(5)
  String? icon;

  @HiveField(6)
  double? windSpeed;

  @HiveField(7)
  int? humidity;

  @HiveField(8)
  int? sunrise;

  @HiveField(9)
  int? sunset;

  @HiveField(10)
  String? country;

  WeatherModel({
    this.name,
    this.temp,
    this.tempMin,
    this.tempMax,
    this.description,
    this.icon,
    this.windSpeed,
    this.humidity,
    this.sunrise,
    this.sunset,
    this.country,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      name: json["name"],
      temp: json["main"]?["temp"]?.toDouble(),
      tempMin: json["main"]?["temp_min"]?.toDouble(),
      tempMax: json["main"]?["temp_max"]?.toDouble(),
      description: json["weather"] != null && json["weather"].isNotEmpty
          ? json["weather"][0]["description"]
          : null,
      icon: json["weather"] != null && json["weather"].isNotEmpty
          ? json["weather"][0]["icon"]
          : null,
      windSpeed: json["wind"]?["speed"]?.toDouble(),
      humidity: json["main"]?["humidity"],
      sunrise: json["sys"]?["sunrise"],
      sunset: json["sys"]?["sunset"],
      country: json["sys"]?["country"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "main": {
          "temp": temp,
          "temp_min": tempMin,
          "temp_max": tempMax,
          "humidity": humidity,
        },
        "weather": [
          {
            "description": description,
            "icon": icon,
          }
        ],
        "wind": {
          "speed": windSpeed,
        },
        "sys": {
          "sunrise": sunrise,
          "sunset": sunset,
          "country": country,
        },
      };
}

WeatherModel weatherModelFromJson(String str) =>
    WeatherModel.fromJson(json.decode(str));

String weatherModelToJson(WeatherModel data) => json.encode(data.toJson());
