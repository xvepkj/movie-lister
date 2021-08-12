import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_lister/screens/info_screen.dart';

import 'models/movie.dart';

main() async{
  // Initialize hive
  await Hive.initFlutter();
  // Registering the adapter
  Hive.registerAdapter(MovieAdapter());
  await Hive.openBox('movieBox');
  // Open the movieBox
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Lister',
      theme: ThemeData(
        primaryColor: Colors.grey,
        primarySwatch: Colors.grey
      ),
      debugShowCheckedModeBanner: false,
      home: InfoScreen(),
    );
  }
}