import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weatherapp/screens/main_screen.dart';
import 'package:weatherapp/screens/utils/location.dart';
import 'package:weatherapp/screens/utils/weather.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late LocationHelper locationData;
  Future<void> getLocationData() async {
    locationData = LocationHelper();
    await locationData.getCurrentLocation();
    // ignore: unnecessary_null_comparison
    if (locationData.latitude == null || locationData.longitude == null) {
      print("konum gelemedi");
    } else {
      print("latitude:${locationData.latitude}".toString());
      print("latitude:${locationData.longitude}".toString());
    }
  }

  void getWeatherData() async {
    await getLocationData();
    // ignore: unused_local_variable
    WeatherData weatherData = WeatherData(locationData: locationData);
    await weatherData.getCurrentTempurature();
    if (weatherData.currentTemperature == 0 ||
        weatherData.currentCondition == 0) {
      print("Api sicaq  gelmiyor");
    }
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return MainScreen(
        weatherData: weatherData,
      );
    }));
  }

  @override
  void initState() {
    super.initState();
    getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.purple, Colors.blue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: const SpinKitFadingCircle(
          color: Colors.white,
          size: 150,
          duration: Duration(milliseconds: 1200),
        ),
      ),
    );
  }
}
