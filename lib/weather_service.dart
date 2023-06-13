import 'package:http/http.dart' as http;
import 'dart:convert';
import 'weather_model.dart';
import 'package:location/location.dart';

class WeatherService {
  Location location = Location();
  var lat = 0.0, lon = 0.0;
  getLocation() async {

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    lat = _locationData.latitude!;
    lon = _locationData.longitude!;
  }
  Future<Weather> fetchWeather() async {
    await getLocation();
    final apiKey = 'cac444e4829a139062ba28aea82c75bf';
    final apiUrl =
        'https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&appid=$apiKey&units=metric';

    final response = await http.get(Uri.parse(apiUrl));
    final jsonData = jsonDecode(response.body);

    final city = jsonData['name'];
    final temp = jsonData['main']['temp'];
    final desc = jsonData['weather'][0]['main'];
    return Weather(
      city: city,
      temp: temp,
      desc: desc,
    );
  }
}
