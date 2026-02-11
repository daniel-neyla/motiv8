import 'package:flutter/material.dart';

import 'app_scaffold.dart';

void main() {
  runApp(const Motiv8App());
}

class Motiv8App extends StatelessWidget {
  const Motiv8App({super.key});

  static const Color motiv8Teal = Color(0xFF00BFA5);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Motiv8',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: motiv8Teal,
          brightness: Brightness.light,
          surface: Color(0xFFF9F9F9),
        ),
        textTheme: TextTheme(
          titleMedium: TextStyle(fontWeight: FontWeight.bold),
          headlineSmall: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),

        fontFamily: 'Serif',
      ),
      home: const AppScaffold(),
    );
  }
}
