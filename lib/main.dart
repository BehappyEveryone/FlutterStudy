
import 'package:flutter/material.dart';
import 'package:study_toon/screen/movies_home.dart';
import 'package:study_toon/screen/pomodoro.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return MaterialApp(
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          background: const Color(0xFFE7626C),
        ),
        textTheme: theme.textTheme.copyWith(
          displayLarge: const TextStyle(
            color: Color(0xFF232B55)
          ),
        ),
        cardColor: const Color(0xFFF4EDDB)
      ),
      home: MoviesHomeScreen(),
    );
  }
}
