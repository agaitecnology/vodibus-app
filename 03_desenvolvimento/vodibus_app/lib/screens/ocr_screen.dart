import 'package:flutter/material.dart';
import 'package:vodibus_app/theme/app_colors.dart';
import 'package:vodibus_app/services/ocr_service.dart';

class OcrScreen extends StatefulWidget {
  const OcrScreen({super.key});

  @override
  State<OcrScreen> createState() => _OcrScreenState();
}

class _OcrScreenState extends State<OcrScreen> {
  String? _textoCompleto;
  String? _enderecoExtraido;
  bool _processando = false;

  Future<void> _fotografar() async {
    setState(() {
      _processando = true;
      _textoCompleto = null;
      _enderecoExtraido = null;
    });

    final texto = await OcrService.fotografarEExtrairTexto();

    if (!mounted) return;

    if (texto == null) {
      setState(() => _processando = false);
      return;
    }

    final endereco = OcrService.extrairEndereco(texto);

    setState(() {
      _textoCompleto = texto;
      _enderecoExtraido = endereco;
      _processando = false;
    });
  }

  void _confirmarEndereco() {
    if (_enderecoExtraido != null) {
      Navigator.pop(context, _enderecoExtraido);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cinzaFundo,
      appBar: AppBar(
        backgroundColor: AppColors.azulEscuro,
        title: const Text(
          'Fotografar endereço',
          style: TextStyle(
            color: AppColors.branco,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.branco),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Instrução
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.azulMedio, Color(0xFF0051D5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                children: [
                  Icon(Icons.camera_alt, color: AppColors.branco, size: 48),
                  SizedBox(height: 12),
                  Text(
                    'Fotografe um endereço',
                    style: TextStyle(
                      color: AppColors.branco,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Aponte a câmera para uma placa de rua,\ncartão ou papel com o endereço',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 15),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Processando
            if (_processando)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Column(
                  children: [
                    CircularProgressIndicator(color: AppColors.azulMedio),
                    SizedBox(height: 16),
                    Text(
                      'Lendo o endereço...',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.cinzaTexto,
                      ),
                    ),
                  ],
                ),
              )
            // Resultado
            else if (_enderecoExtraido != null) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.branco,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.location_on, color: AppColors.azulMedio),
                        SizedBox(width: 8),
                        Text(
                          'Endereço encontrado',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.cinzaTexto,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _enderecoExtraido!,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.azulEscuro,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              if (_textoCompleto != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.verdeAzulado,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Texto completo lido:',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.azulEscuro,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _textoCompleto!,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.cinzaTexto,
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: _confirmarEndereco,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.verde,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  icon: const Icon(Icons.check, color: AppColors.branco),
                  label: const Text(
                    'Usar este endereço',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.branco,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: _fotografar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.azulMedio,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  icon: const Icon(Icons.camera_alt, color: AppColors.branco),
                  label: const Text(
                    'Fotografar novamente',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.branco,
                    ),
                  ),
                ),
              ),
            ]
            // Botão inicial
            else
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: SizedBox(
                  width: double.infinity,
                  height: 70,
                  child: ElevatedButton.icon(
                    onPressed: _fotografar,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.amarelo,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    icon: const Icon(
                      Icons.camera_alt,
                      color: AppColors.azulEscuro,
                      size: 32,
                    ),
                    label: const Text(
                      'Abrir câmera',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.azulEscuro,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
