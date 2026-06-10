import '../model/space_weather_event.dart';

abstract class SpaceWeatherRepository {
  Future<List<SpaceWeatherEvent>> getEvents();
  Future<List<String>> getFavorites();
  Future<void> toggleFavorite(String id);
}
