import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const VoDiBusApp());
}

class VoDiBusApp extends StatelessWidget {
  const VoDiBusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VoDiBus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1565C0)),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
