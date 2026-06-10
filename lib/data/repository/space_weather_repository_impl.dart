import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/model/space_weather_event.dart';
import '../../domain/repository/space_weather_repository.dart';
import '../remote/nasa_api_service.dart';

class SpaceWeatherRepositoryImpl implements SpaceWeatherRepository {
  final NasaApiService api;
  SpaceWeatherRepositoryImpl(this.api);

  String _risk(double kp) {
    if (kp <= 4) return 'low';
    if (kp <= 7) return 'moderate';
    return 'severe';
  }

  @override
  Future<List<SpaceWeatherEvent>> getEvents() async {
    final dtos = await api.getGstEvents();
    return dtos.map((dto) {
      final severity = _risk(dto.kpIndex);
      return SpaceWeatherEvent(
        id: dto.gstID,
        title: 'Tempestade geomagnética ${dto.gstID}',
        startTime: dto.startTime,
        kp: dto.kpIndex,
        severity: severity,
        emergencyNotification: severity == 'severe',
        link: dto.link,
      );
    }).toList();
  }

  @override
  Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('favorites') ?? [];
  }

  @override
  Future<void> toggleFavorite(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList('favorites') ?? [];
    if (favorites.contains(id)) {
      favorites.remove(id);
    } else {
      favorites.add(id);
    }
    await prefs.setStringList('favorites', favorites);
  }
}
