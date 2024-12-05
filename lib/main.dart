import 'package:flutter/material.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'list_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/news': (context) => const ListPage(title: 'News', apiEndpoint: 'https://api.spaceflightnewsapi.net/v4/articles'),
        '/blogs': (context) => const ListPage(title: 'Blogs', apiEndpoint: 'https://api.spaceflightnewsapi.net/v4/blogs'),
        '/reports': (context) => const ListPage(title: 'Reports', apiEndpoint: 'https://api.spaceflightnewsapi.net/v4/reports'),
      },
    );
  }
}
