import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:minimal_weather_app/models/weather_model.dart';
import 'package:minimal_weather_app/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // api key
  final _weatherService = WeatherService('bd620c384bf8606362e2a32cd7644178');
  Weather? _weather;

  // fetch weather
  _fetchWeather() async {
    // get the current city
    String cityName = await _weatherService.getCurrentCity();

    // get weather for the city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }

    // any errors
    catch (e) {
      print(e);
    }
  }

  // init state
  @override
  void initState() {
    super.initState();

    // fetch weaather on startup
    _fetchWeather();
  }

  // weather animations
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'lib/assets/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
        return 'lib/assets/cloudy.json';
      case 'mist':
      case 'fog':
        return 'lib/assets/cloudy.json';
      case 'shower rain':
        return 'lib/assets/rainy.json';
      case 'thunderstorm':
        return 'lib/assets/thunder.json';
      case 'clear':
        return 'lib/assets/sunny.json';
      default:
        return 'lib/assets/sunny.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // city name
            Text(
              _weather?.cityName ?? 'Loading city...',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 24,
                color: Colors.white,
                letterSpacing: 2.0,
              ),
            ),

            // animation
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

            // temperature
            Text(
              '${_weather?.temperature.round()}\u00B0C',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 24,
                  letterSpacing: 1.5,
                  color: Colors.white),
            ),

            // weather condition
            Text(
              _weather?.mainCondition ?? "",
              style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'Roboto',
                  color: Colors.white,
                  letterSpacing: 1.0),
            )
          ],
        ),
      ),
    );
  }
}
