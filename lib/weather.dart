import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherView extends StatefulWidget {
  @override
  _WeatherViewState createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  String apiKey = '3def3af13609ce2e5a7392ee52305458'; // Coloca aquí tu API Key de OpenWeather
  String city = 'La Romana';
  Map<String, dynamic>? weatherData;

  Future<void> fetchWeather() async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric'));
    if (response.statusCode == 200) {
      setState(() {
        weatherData = jsonDecode(response.body);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clima en RD'),
      ),
      body: Center(
        child: weatherData == null
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Ciudad: $city',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Temperatura: ${weatherData!['main']['temp']}°C',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Condición: ${weatherData!['weather'][0]['description']}',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
      ),
    );
  }
}