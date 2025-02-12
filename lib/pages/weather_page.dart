import 'package:flutter/material.dart';
import 'package:minimal_weather_app/models/weather_model.dart';
import 'package:minimal_weather_app/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // api key
  final _weatherService = WeatherService('e1760d40b2308c406d6ed93eac9b7916');
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
  }


  @override
  Widget build(BuildContext context) {
   return Scaffold(
    body: Column(
      children: [
        // city name
        Text(_weather?.cityName ?? 'city...'),

        // temperature
        Text(${_weather?.temperature.round()}'C')
      ],
    ),
   );
  }
}
