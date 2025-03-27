import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:wheater_app/utils/api.dart';
import 'package:wheater_app/widgets/my_icon.dart';

const apikey = "4ba516897c920f8156f80f3760220f81";

class IconDedector {
  IconDedector({
    required this.tempeture,
    required this.condition,
  });
  double tempeture;
  String? durum;
  int condition;
  Icon? icon;
  double adjustTemperature() {
    tempeture = (tempeture - 272.12);
    return double.parse(
      tempeture.toStringAsFixed(2),
    );
  }

  Widget getir() {
    if (condition < 300) {
      durum = "Fırtına";
    } else if (condition >= 300 && condition < 400) {
      durum = "Çok az yağmurlu";
    } else if (condition >= 500 && condition < 600) {
      durum = "Yağmurlu";
    } else if (condition >= 600 && condition < 700) {
      durum = "Karlı";
    } else if (condition >= 700) {
      durum = "Güneşli";
    }
    return const SizedBox();
  }

  Widget get_pc(double w, double h) {
    if (durum == "Fırtına") {
      durum = "Fırtına";
      return MyGif(path: "assets/storm.gif", width: w, height: h);
    } else if (durum == "Çok az yağmurlu") {
      durum = "Çok az yağmurlu";
      return MyGif(path: "assets/clouds.gif", width: w, height: h);
    } else if (durum == "Yağmurlu") {
      durum = "Yağmurlu";
      return MyGif(path: "assets/rain.gif", width: w, height: h);
    } else if (durum == "Karlı") {
      durum = "Karlı";
      return MyGif(path: "assets/weather-3.gif", width: w, height: h);
    } else if (durum == "Güneşli") {
      durum = "Güneşli";
      return MyGif(path: "assets/sun.gif", width: w, height: h);
    }
    return Container(
      width: 50,
      height: 20,
      color: Colors.amber,
    );
  }
}

class WeatherData {
  WeatherData({required this.location});
  late Data location;
  late var currentTemperature;
  late int currentCondition;
  late String country;
  Future<void> getTemperature() async {
    final response = await get(
      Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=${location.lat}&lon=${location.long}&appid=$apikey",
      ),
    );

    if (response.statusCode == 200) {
      String data = response.body;

      var currentWeather = jsonDecode(data);
      try {
        currentTemperature = currentWeather["main"]["temp"];
        currentCondition = currentWeather["weather"][0]["id"];
        country = currentWeather["sys"]["country"];
        print(currentTemperature);
        print(currentCondition);
      } catch (e) {
        print("Hata: $e");
      }
    } else {
      print("API isteği başarısız: ${response.statusCode}");
    }
  }
}
