import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GenderPredict extends StatefulWidget {
  @override
  _GenderPredictState createState() => _GenderPredictState();
}

class _GenderPredictState extends State<GenderPredict> {
  final TextEditingController _controller = TextEditingController();
  String? _gender;
  Color _color = Colors.white;

  Future<void> _predictGender(String name) async {
    final response = await http.get(Uri.parse('https://api.genderize.io/?name=$name'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _gender = data['gender'];
        _color = (_gender == 'male') ? Colors.blue : Colors.pink;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Predicción de Género'),
      ),
      body: Container(
        color: _color,
        child: Center(
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
                  _predictGender(_controller.text);
                },
                child: Text('Predecir Género'),
              ),
              SizedBox(height: 20),
              if (_gender != null) Text('Género: $_gender'),
            ],
          ),
        ),
      ),
    );
  }
}