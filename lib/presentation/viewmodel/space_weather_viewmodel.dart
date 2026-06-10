import 'package:flutter/material.dart';
import '../../domain/model/space_weather_event.dart';
import '../../domain/repository/space_weather_repository.dart';
import '../../domain/usecase/get_events_usecase.dart';

enum ViewState { initial, loading, success, error }

class SpaceWeatherViewModel extends ChangeNotifier {
  final GetEventsUseCase getEventsUseCase;
  final SpaceWeatherRepository repository;

  SpaceWeatherViewModel(this.getEventsUseCase, this.repository);

  ViewState state = ViewState.initial;
  List<SpaceWeatherEvent> events = [];
  List<String> favorites = [];
  String search = '';
  String errorMessage = '';

  List<SpaceWeatherEvent> get filteredEvents => events
      .where((event) => event.title.toLowerCase().contains(search.toLowerCase()) || event.severity.contains(search.toLowerCase()))
      .toList();

  Future<void> loadEvents() async {
    state = ViewState.loading;
    notifyListeners();
    try {
      events = await getEventsUseCase();
      favorites = await repository.getFavorites();
      state = ViewState.success;
    } catch (e) {
      errorMessage = e.toString();
      state = ViewState.error;
    }
    notifyListeners();
  }

  Future<void> toggleFavorite(String id) async {
    await repository.toggleFavorite(id);
    favorites = await repository.getFavorites();
    notifyListeners();
  }

  void updateSearch(String value) {
    search = value;
    notifyListeners();
  }
}
