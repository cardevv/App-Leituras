// TP7 - App de Organização de Leituras
// Integrante: Carlos Eduardo da Silva Santos

import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const AppLeituras());
}

class AppLeituras extends StatelessWidget {
  const AppLeituras({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minhas Leituras',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const HomeScreen(),
    );
  }
}
