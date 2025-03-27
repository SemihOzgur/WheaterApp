import 'package:flutter/material.dart';
import 'package:wheater_app/utils/api.dart';
import 'package:wheater_app/utils/wheater.dart';
import 'package:wheater_app/widgets/my_text.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Data data;

  Future<void> getLocationData() async {
    data = Data();
    await data.getCurrentLocation();

    if (data.lat == null || data.long == null) {
      print("KONUM YOK");
    } else {
      print("LAT =" + data.lat.toString() + " LONG = " + data.long.toString());
    }
  }

  Future<WeatherData> getWheaterData() async {
    await getLocationData();
    WeatherData weatherData = WeatherData(location: data);
    await weatherData.getTemperature();

    if (weatherData.currentCondition == null ||
        weatherData.currentTemperature == null) {
      print("Veri boş");
      throw Exception("Hava durumu verisi alınamadı");
    }
    return weatherData;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
    double screen_height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FutureBuilder<WeatherData>(
          future: getWheaterData(), // Burada future'ı belirtiyoruz
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Yükleniyor durumu
            } else if (snapshot.hasError) {
              return Text('Hata: ${snapshot.error}'); // Hata durumu
            } else if (snapshot.hasData) {
              WeatherData weatherData = snapshot.data!;
              IconDedector iconDedector = IconDedector(
                tempeture: weatherData.currentTemperature,
                condition: weatherData.currentCondition,
              );
              return Center(
                child: Column(
                  children: [
                    iconDedector.getir(),
                    Icon(
                      Icons.location_on,
                      size: screen_height / 13,
                    ),
                    MyText(txt: weatherData.country, size: screen_width / 10),
                    iconDedector.get_pc(screen_width, screen_height / 3),
                    MyText(
                      txt: iconDedector.durum.toString(),
                      size: screen_width / 10,
                    ),
                    SizedBox(
                      height: screen_height / 10,
                    ),
                    MyText(
                      txt: iconDedector.adjustTemperature().toString() + " °C",
                      size: screen_width / 10,
                    )
                  ],
                ),
              );
            } else {
              return Text('Veri yok'); // Diğer durum
            }
          },
        ),
      ),
    );
  }
}
