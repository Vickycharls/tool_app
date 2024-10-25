import 'package:flutter/material.dart';
import 'package:tool_app/gender_predict.dart';
import 'package:tool_app/age_predict.dart';
import 'package:tool_app/university_list.dart';
import 'package:tool_app/weather.dart';
import 'package:tool_app/news_view.dart';
import 'package:tool_app/about.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tool App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tool App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/toolbox.png'), // Imagen de caja de herramientas
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GenderPredict()),
                );
              },
              child: Text('Predecir Género'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AgePredict()),
                );
              },
              child: Text('Predecir Edad'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UniversityList()),
                );
              },
              child: Text('Lista de Universidades'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WeatherView()),
                );
              },
              child: Text('Clima en RD'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewsView()),
                );
              },
              child: Text('Noticias WordPress'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutPage()),
                );
              },
              child: Text('Acerca de'),
            ),
          ],
        ),
      ),
    );
  }
}