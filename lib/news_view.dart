import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart'; // Para abrir links en el navegador

class NewsView extends StatefulWidget {
  @override
  _NewsViewState createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  List<dynamic> posts = [];

  // Función para obtener las publicaciones desde la API REST de WordPress
  Future<void> fetchPosts() async {
    final response = await http.get(Uri.parse('https://time.com/wp-json/wp/v2/posts'));
    
    if (response.statusCode == 200) {
      setState(() {
        posts = jsonDecode(response.body);
      });
    } else {
      throw Exception('Fallo al cargar las publicaciones');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPosts(); // Llama a la función cuando se carga la vista
  }

  Future<void> _launchURL(String url) async {
    final Uri launchUri = Uri.parse(url); // Convierte la cadena a Uri
    if (await canLaunchUrl(launchUri)) { // Verifica si se puede lanzar la URL
      await launchUrl(launchUri); // Usa launchUrl en lugar de launch
    } else {
      throw 'No se pudo abrir el enlace';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Últimas Noticias'),
      ),
      body: posts.isEmpty
          ? Center(child: CircularProgressIndicator()) // Muestra un loader mientras se cargan las noticias
          : ListView.builder(
              itemCount: posts.length > 3 ? 3 : posts.length, // Mostramos solo las 3 primeras noticias
              itemBuilder: (context, index) {
                final post = posts[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(post['title']['rendered']), // Título de la noticia
                    subtitle: Text(
                      post['excerpt']['rendered'].replaceAll(RegExp(r'<[^>]*>'), ''), // Resumen sin HTML
                    ),
                    trailing: Icon(Icons.link),
                    onTap: () async {
                      final url = post['link']; // Link a la noticia original
                      await _launchURL(url); // Llama a la función para abrir el enlace
                    },
                  ),
                );
              },
            ),
    );
  }
}