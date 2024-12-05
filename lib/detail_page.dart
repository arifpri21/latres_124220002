import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailPage extends StatelessWidget {
  final int id;
  final String type;

  const DetailPage({super.key, required this.id, required this.type});

  Future<Map<String, dynamic>> fetchDetails() async {
    final response = await http
        .get(Uri.parse('https://api.spaceflightnewsapi.net/v4/$type/$id'));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail')),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final data = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data['title'],
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              Text(data['summary']),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.open_in_browser),
        onPressed: () {
          // Navigate to the web URL
        },
      ),
    );
  }
}
