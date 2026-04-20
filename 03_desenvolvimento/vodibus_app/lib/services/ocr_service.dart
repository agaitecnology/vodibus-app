import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class OcrService {
  static final _textRecognizer = TextRecognizer(
    script: TextRecognitionScript.latin,
  );
  static final _imagePicker = ImagePicker();

  // Fotografa e extrai texto
  static Future<String?> fotografarEExtrairTexto() async {
    try {
      final foto = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );

      if (foto == null) return null;

      final inputImage = InputImage.fromFilePath(foto.path);
      final textoReconhecido = await _textRecognizer.processImage(inputImage);

      return textoReconhecido.text.isNotEmpty ? textoReconhecido.text : null;
    } catch (e) {
      debugPrint('Erro OCR: $e');
      return null;
    }
  }

  // Extrai endereço do texto reconhecido
  static String? extrairEndereco(String texto) {
    final linhas = texto.split('\n');

    // Padrões de endereço brasileiro
    final padroes = [
      RegExp(
        r'(Rua|R\.|Av\.|Avenida|Al\.|Alameda|Pç\.|Praça|Rod\.|Rodovia)\s+.+,?\s*\d+',
        caseSensitive: false,
      ),
      RegExp(r'(Rua|Avenida|Av|Alameda|Praça)\s+\w+', caseSensitive: false),
    ];

    for (final linha in linhas) {
      for (final padrao in padroes) {
        if (padrao.hasMatch(linha)) {
          return linha.trim();
        }
      }
    }

    // Se não encontrar padrão, retorna primeira linha com mais de 10 chars
    return linhas.where((l) => l.trim().length > 10).firstOrNull?.trim();
  }

  static void dispose() {
    _textRecognizer.close();
  }
}
