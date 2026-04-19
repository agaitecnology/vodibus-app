import 'package:flutter/material.dart';
import 'package:vodibus_app/main.dart';
import 'package:vodibus_app/theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.verdeAzulado,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.directions_bus,
              size: 100,
              color: AppColors.azulEscuro,
            ),
            const SizedBox(height: 24),
            RichText(
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  letterSpacing: -1.5,
                ),
                children: [
                  TextSpan(
                    text: 'Vo',
                    style: TextStyle(color: AppColors.azulEscuro),
                  ),
                  TextSpan(
                    text: 'Di',
                    style: TextStyle(color: AppColors.amarelo),
                  ),
                  TextSpan(
                    text: 'Bus',
                    style: TextStyle(color: AppColors.azulEscuro),
                  ),
                  TextSpan(
                    text: '!',
                    style: TextStyle(color: AppColors.azulMedio),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Ônibus na palma da mão — simples assim!',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.cinzaTexto,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 48),
            const CircularProgressIndicator(color: AppColors.amarelo),
          ],
        ),
      ),
    );
  }
}
