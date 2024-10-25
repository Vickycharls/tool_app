import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class UniversityList extends StatefulWidget {
  @override
  _UniversityListState createState() => _UniversityListState();
}

class _UniversityListState extends State<UniversityList> {
  List<dynamic> universities = [];

  @override
  void initState() {
    super.initState();
    fetchUniversities();
  }

  Future<void> fetchUniversities() async {
    final response = await http.get(
      Uri.parse('http://universities.hipolabs.com/search?country=Dominican+Republic'),
    );

    if (response.statusCode == 200) {
      setState(() {
        universities = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load universities');
    }
  }

  Future<void> _launchURL(String url) async {
    final Uri launchUri = Uri.parse(url);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Universities in Dominican Republic'),
      ),
      body: universities.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: universities.length,
              itemBuilder: (context, index) {
                final university = universities[index];
                return ListTile(
                  title: Text(university['name']),
                  subtitle: Text(university['domain']),
                  onTap: () {
                    _launchURL(university['website']); // Llama a la función actualizada
                  },
                );
              },
            ),
    );
  }
}