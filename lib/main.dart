import 'package:climateeee/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Climate());
}

class Climate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}