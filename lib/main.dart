// @dart = 2.9
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:livros/screens/livros_bookmarks.dart';

import 'screens/livros_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home), text: "Home"),
                Tab(icon: Icon(Icons.bookmark), text: "Favoritos"),
              ],
            ),
            title: const Text('Livros', style: TextStyle(fontSize: 22),),
          ),
          body: const TabBarView(
            children: [
              LivrosPage(),
              LivrosBookmark(),
            ],
          ),
        ),
      ),
      routes: {'/homeScreen': (_) => MyApp()},
    );
  }
}
