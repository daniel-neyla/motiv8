import 'package:flutter/material.dart';

void main() {
  runApp(const Motiv8App());
}

class Motiv8App extends StatelessWidget {
  const Motiv8App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Motiv8',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const TodayView(),
    );
  }
}

class TodayView extends StatelessWidget {
  const TodayView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Today')));
  }
}
