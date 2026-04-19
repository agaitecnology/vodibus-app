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
      if (lugares.isEmpty) return 'Endereço não encontrado';

      final lugar = lugares.first;
      final partes = [
        lugar.street,
        lugar.subLocality,
        lugar.locality,
      ].where((p) => p != null && p.isNotEmpty).toList();

      return partes.join(', ');
    } catch (e) {
      return 'Endereço não disponível';
    }
  }

  static String formatarCoordenadas(Position posicao) {
    final lat = posicao.latitude.toStringAsFixed(6);
    final lng = posicao.longitude.toStringAsFixed(6);
    return 'Lat: $lat, Lng: $lng';
  }
}
