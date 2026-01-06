import 'package:flutter/material.dart';
import '../today/today_view.dart';

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
          surface: Color.fromARGB(255, 240, 240, 240),
        ),
      ),
      home: const TodayView(),
    );
  }
}
