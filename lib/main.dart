import 'package:flutter/material.dart';
import 'package:news_flutter/views/homepage.dart';



void main() =>
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
     '/': (context) => const HomePage(),
    }
  ));
