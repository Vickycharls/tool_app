import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acerca de'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/foto.jpg'), 
            ),
            SizedBox(height: 20),
            Text(
              'Vicmairy Charles',
              style: TextStyle(fontSize: 24),
            ),
            Text('Desarrollador de Software'),
            SizedBox(height: 10),
            Text('Email: vicmairycharles@gmail.com'),
            Text('Teléfono: +1 829-918-9039'),
          ],
        ),
      ),
    );
  }
}