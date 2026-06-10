import '../model/space_weather_event.dart';
import '../repository/space_weather_repository.dart';

class GetEventsUseCase {
  final SpaceWeatherRepository repository;
  GetEventsUseCase(this.repository);
  Future<List<SpaceWeatherEvent>> call() => repository.getEvents();
}
