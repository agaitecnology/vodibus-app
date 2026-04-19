import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/favoritos_screen.dart';

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

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _indiceAtual = 0;

  final List<Widget> _telas = const [HomeScreen(), FavoritosScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _telas[_indiceAtual],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceAtual,
        onTap: (index) {
          setState(() {
            _indiceAtual = index;
          });
        },
        selectedItemColor: const Color(0xFF1565C0),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favoritos'),
        ],
      ),
    );
  }
}
