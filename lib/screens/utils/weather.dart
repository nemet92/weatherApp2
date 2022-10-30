import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';

import 'location.dart';

const apiKey = "14d5a28c3c5660a57719765c063e2deb";

class WeatherDisplayData {
  Icon? weatherIcon;
  Widget? weatherImage;
  WeatherDisplayData({this.weatherIcon, this.weatherImage});
}

class WeatherData {
  WeatherData({required this.locationData});
  LocationHelper locationData;
  double? currentTemperature;
  int? currentCondition;

  ////
  Future<void> getCurrentTempurature() async {
    final response = await get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=$apiKey&unit=metric"));
    if (response.statusCode == 200) {
      String data = response.body;
      var currentWeather = jsonDecode(data);
      try {
        currentTemperature = currentWeather['main']['temp'];
        currentCondition = currentWeather['weather'][0]['id'];
      } catch (e) {
        // ignore: avoid_print
        print(e);
      }
    } else {
      print("api den deyer gelmedi");
    }
  }

  WeatherDisplayData getWeatherDisplayData() {
    if (currentCondition! < 600) {
      //hava b
      return WeatherDisplayData(
          weatherIcon: const Icon(
            FontAwesomeIcons.cloud,
            size: 75,
            color: Colors.white,
          ),
          weatherImage: Image.asset("assets/bulutlu.png"));
    } else {
      var now = DateTime.now();
      if (now.hour >= 19) {
        return WeatherDisplayData(
            weatherIcon: const Icon(
              FontAwesomeIcons.moon,
              size: 75,
              color: Colors.white,
            ),
            weatherImage: Image.asset("assets/gece.png"));
      } else {
        return WeatherDisplayData(
            weatherIcon: const Icon(
              FontAwesomeIcons.sun,
              size: 75,
              color: Colors.white,
            ),
            weatherImage: Image.asset("assets/sun2.jpg"));
      }
    }
  }
}
