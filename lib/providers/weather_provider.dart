import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_tour_mate/models/current_model.dart';
import 'package:http/http.dart' as Http;
import 'package:geolocator/geolocator.dart' as Geo;

class WeatherProvider with ChangeNotifier {
  late CurrentWeatherResponse _currentWeatherResponse;

  CurrentWeatherResponse get currentData => _currentWeatherResponse;

  Future getCurrentWeatherInfo(Geo.Position position) async {
    final url =
        'https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&units=metric&appid=db171b97d4e7a84e56129f84d0ff79d8';
    try {
      final response = await Http.get(url);
      //print(response.body);
      final map = json.decode(response.body);
      _currentWeatherResponse = CurrentWeatherResponse.fromJson(map);
      print('temp: ${_currentWeatherResponse.main.temp}');
    } catch (error) {
      throw error;
    }
  }
}
