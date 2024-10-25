import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AgePredict extends StatefulWidget {
  @override
  _AgePredictState createState() => _AgePredictState();
}

class _AgePredictState extends State<AgePredict> {
  final TextEditingController _controller = TextEditingController();
  String? _ageCategory;
  String? _ageNumber;

  Future<void> _predictAge(String name) async {
    final response = await http.get(Uri.parse('https://api.agify.io/?name=$name'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      int age = data['age'];
      String category = age < 18 ? 'Joven' : (age < 60 ? 'Adulto' : 'Anciano');
      setState(() {
        _ageNumber = age.toString();
        _ageCategory = category;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Predicción de Edad'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Ingrese un nombre'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _predictAge(_controller.text);
              },
              child: Text('Predecir Edad'),
            ),
            SizedBox(height: 20),
            if (_ageCategory != null)
              Column(
                children: [
                  Text('Edad: $_ageNumber años'),
                  Text('Categoría: $_ageCategory'),
                ],
              ),
          ],
        ),
      ),
    );
  }
}