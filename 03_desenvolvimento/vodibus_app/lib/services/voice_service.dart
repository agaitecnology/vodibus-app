import 'package:flutter/foundation.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VoiceService {
  static final SpeechToText _speech = SpeechToText();
  static bool _inicializado = false;

  static Future<bool> inicializar() async {
    if (_inicializado) return true;
    _inicializado = await _speech.initialize(
      onError: (error) => debugPrint('Erro de voz: $error'),
      onStatus: (status) => debugPrint('Status de voz: $status'),
    );
    return _inicializado;
  }

  static Future<void> ouvir({
    required Function(String texto) onResultado,
    required Function() onFim,
  }) async {
    final disponivel = await inicializar();
    if (!disponivel) return;

    await _speech.listen(
      onResult: (resultado) {
        if (resultado.finalResult) {
          onResultado(resultado.recognizedWords);
          onFim();
        }
      },
      localeId: 'pt_BR',
      listenFor: const Duration(seconds: 10),
      pauseFor: const Duration(seconds: 3),
    );
  }

  static Future<void> parar() async {
    await _speech.stop();
  }

  static bool get escutando => _speech.isListening;
  static bool get disponivel => _inicializado;
}
