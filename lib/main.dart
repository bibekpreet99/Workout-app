import 'package:flutter/material.dart';
import 'package:workout/screens/exercisePage.dart';
import 'screens/Home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context)=>Home(),
        '/exercise': (context)=>ExercisePage()
      },
    );
  }
}
