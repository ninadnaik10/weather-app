import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_provider/weather_provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text("Weather app"),
          ),
          body: Center(
            child: Consumer<WeatherProvider>(
              builder: (context, provider, child){
                provider.fetchWeather();
                final weather = provider.currentWeather;
                if (provider.isLoading == false && weather != null) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('City: ${weather.city}'),
                      Text('Temperature: ${weather.temp}'),
                      Text('Weather Condition: ${weather.desc}'),
                    ],
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
