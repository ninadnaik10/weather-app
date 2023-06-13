import 'package:flutter/cupertino.dart';

import 'weather_model.dart';
import 'weather_service.dart';

class WeatherProvider with ChangeNotifier {
  Weather? _currentWeather;
  final WeatherService _weatherService = WeatherService();

  Weather? get currentWeather => _currentWeather;
  bool isLoading = true;

  Future<void> fetchWeather() async {
    final weatherData = await _weatherService.fetchWeather();
    _currentWeather = weatherData;
    isLoading = false;
    notifyListeners();
  }
}
