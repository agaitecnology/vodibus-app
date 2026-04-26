import 'package:flutter/material.dart';
import 'package:vodibus_app/main.dart';
import 'package:vodibus_app/theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _mostrarSegundoSplash = false;

  @override
  void initState() {
    super.initState();
    _iniciarSequencia();
  }

  Future<void> _iniciarSequencia() async {
    // Primeiro splash — logo — 2s
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => _mostrarSegundoSplash = true);

    // Segundo splash — pessoa embarcando — 3s
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const MainScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2ecc71),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 600),
        child: _mostrarSegundoSplash ? _splashPessoa() : _splashLogo(),
      ),
    );
  }

  Widget _splashLogo() {
    return SizedBox.expand(
      key: const ValueKey('logo'),
      child: Image.asset('assets/images/flash_logo.png', fit: BoxFit.cover),
    );
  }

  Widget _splashPessoa() {
    return Stack(
      key: const ValueKey('pessoa'),
      fit: StackFit.expand,
      children: [
        Image.asset('assets/images/img_app.png', fit: BoxFit.cover),
        Positioned(
          bottom: 48,
          left: 0,
          right: 0,
          child: Column(
            children: [
              const CircularProgressIndicator(
                color: AppColors.amarelo,
                strokeWidth: 3,
              ),
              const SizedBox(height: 16),
              Text(
                'Carregando...',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withValues(alpha: 0.9),
                  fontWeight: FontWeight.w500,
                  shadows: const [Shadow(color: Colors.black54, blurRadius: 4)],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
