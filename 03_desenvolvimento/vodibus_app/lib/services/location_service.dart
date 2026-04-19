import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationService {
  static Future<Position?> obterLocalizacao() async {
    bool servicoAtivo = await Geolocator.isLocationServiceEnabled();
    if (!servicoAtivo) return null;

    LocationPermission permissao = await Geolocator.checkPermission();

    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();
      if (permissao == LocationPermission.denied) return null;
    }

    if (permissao == LocationPermission.deniedForever) return null;

    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );
  }

  static Future<String> obterEndereco(double lat, double lng) async {
    try {
      List<Placemark> lugares = await placemarkFromCoordinates(lat, lng);
      if (lugares.isEmpty) return mensagemFallback(lat, lng);

      final lugar = lugares.first;

      final rua = lugar.street ?? '';
      final numero = lugar.subThoroughfare ?? '';
      final bairro = lugar.subLocality ?? '';
      final cidade = lugar.locality ?? '';

      String endereco = '';
      if (rua.isNotEmpty) {
        endereco = numero.isNotEmpty ? '$rua, $numero' : rua;
      }
      if (bairro.isNotEmpty) {
        endereco += endereco.isNotEmpty ? ' — $bairro' : bairro;
      }
      if (endereco.isEmpty && cidade.isNotEmpty) {
        endereco = cidade;
      }

      return endereco.isNotEmpty ? endereco : mensagemFallback(lat, lng);
    } catch (e) {
      return mensagemFallback(lat, lng);
    }
  }

  static String mensagemFallback(double lat, double lng) {
    return 'Lat: ${lat.toStringAsFixed(4)}, Lng: ${lng.toStringAsFixed(4)}';
  }

  static String formatarCoordenadas(Position posicao) {
    return mensagemFallback(posicao.latitude, posicao.longitude);
  }

  static String mensagemStatus(Position? posicao) {
    if (posicao == null) return 'GPS não disponível — verifique as permissões';
    return '✓ Localização encontrada';
  }

  static String mensagemPermissao() {
    return 'Permita o acesso à localização para encontrar ônibus próximos';
  }
}
