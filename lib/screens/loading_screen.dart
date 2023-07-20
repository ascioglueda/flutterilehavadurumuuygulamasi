import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:havadurumu/screens/main_screen.dart';
import 'package:havadurumu/utils/location.dart';
import 'package:havadurumu/utils/weather.dart';

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
    if (locationData.latitude == null || locationData.longitude == null) {
      print("Konum Bilgileri Gelmiyor");
    } else {
      print("latitude: " + locationData.latitude.toString());
      print("longitude: " + locationData.longitude.toString());
    }
  }

  Future<void> getWeatherData() async {
    await getLocationData();
    WeatherData weatherData = WeatherData(locationData: locationData);
    await weatherData.getCurrentTemperature();
    if (weatherData.currentTemperature == null ||
        weatherData.currentCondition == null) {
      print("API den sıcaklık veya durum bilgisi boş dönüyor");
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MainScreen(weatherData: weatherData),
      ),
    );
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.purple, Colors.blue],
          ),
        ),
        child: Center(
          child: SpinKitPianoWave(
            color: Colors.white,
            size: 110.0,
            duration: Duration(milliseconds: 1200),
          ),
        ),
      ),
    );
  }
}
