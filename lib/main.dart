import 'package:flutter/material.dart';
import 'package:tutorinsa/pages/Common/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'TutorInsa',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
