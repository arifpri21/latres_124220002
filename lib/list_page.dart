import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListPage extends StatelessWidget {
  final String title;
  final String apiEndpoint;

  const ListPage({super.key, required this.title, required this.apiEndpoint});

  Future<List<dynamic>> fetchData() async {
    final response = await http.get(Uri.parse(apiEndpoint));
    return json.decode(response.body)['results'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: FutureBuilder<List<dynamic>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          return ListView.builder(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              final item = snapshot.data![index];
              return ListTile(
                title: Text(item['title']),
                onTap: () => Navigator.pushNamed(
                  context,
                  '/detail',
                  arguments: {'id': item['id'], 'type': title.toLowerCase()},
                ),
              );
            },
          );
        },
      ),
    );
  }
}
