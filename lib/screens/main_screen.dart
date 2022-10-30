import 'package:flutter/material.dart';
import 'package:weatherapp/screens/utils/weather.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, required this.weatherData}) : super(key: key);
  final WeatherData weatherData;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int? temperature;
  Icon? weatherDisplayIcon;
  Widget? backgroundImage;
  void updateDisplayInfo(WeatherData weatherData) {
    setState(() {
      temperature = weatherData.currentTemperature?.round();
      WeatherDisplayData weatherDisplayData =
          weatherData.getWeatherDisplayData();
      backgroundImage = weatherDisplayData.weatherImage;
      weatherDisplayIcon = weatherDisplayData.weatherIcon;
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    updateDisplayInfo(widget.weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Image.asset(
          "$backgroundImage",
          width: double.infinity,
        ),
        Container(
          constraints: const BoxConstraints.expand(),
          // decoration: BoxDecoration(
          //     image: DecorationImage(
          //   image: AssetImage(
          //     "$backgroundImage",
          //   ),
          // )
          // ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 40,
              ),
              Container(
                child: weatherDisplayIcon,
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: Text(
                  "$temperature",
                  style: const TextStyle(
                      color: Colors.white, fontSize: 80, letterSpacing: -5),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
