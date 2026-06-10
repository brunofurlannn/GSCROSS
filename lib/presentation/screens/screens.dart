import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/event_card.dart';
import '../viewmodel/space_weather_viewmodel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Solar Shield')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Icon(Icons.public, size: 64),
        const Text('Monitoramento de Clima Espacial', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Dados espaciais da NASA DONKI para alertas de infraestrutura crítica.'),
        const SizedBox(height: 16),
        ElevatedButton(onPressed: () => Navigator.pushNamed(context, '/events'), child: const Text('Ver eventos')),
      ]),
    ),
  );
}

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SpaceWeatherViewModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('Eventos GST')),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(decoration: const InputDecoration(labelText: 'Buscar por risco ou evento', border: OutlineInputBorder()), onChanged: vm.updateSearch),
        ),
        Expanded(child: _buildState(context, vm)),
      ]),
      floatingActionButton: FloatingActionButton(onPressed: vm.loadEvents, child: const Icon(Icons.refresh)),
    );
  }

  Widget _buildState(BuildContext context, SpaceWeatherViewModel vm) {
    if (vm.state == ViewState.initial) return Center(child: ElevatedButton(onPressed: vm.loadEvents, child: const Text('Carregar dados')));
    if (vm.state == ViewState.loading) return const Center(child: CircularProgressIndicator());
    if (vm.state == ViewState.error) return Center(child: Text('Erro: ${vm.errorMessage}'));
    return ListView(children: vm.filteredEvents.map((event) => EventCard(
      event: event,
      isFavorite: vm.favorites.contains(event.id),
      onTap: () => Navigator.pushNamed(context, '/details', arguments: event),
      onFavorite: () => vm.toggleFavorite(event.id),
    )).toList());
  }
}

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SpaceWeatherViewModel>();
    final favs = vm.events.where((e) => vm.favorites.contains(e.id)).toList();
    return Scaffold(appBar: AppBar(title: const Text('Favoritos')), body: ListView(children: favs.map((e) => EventCard(event: e, isFavorite: true, onTap: () => Navigator.pushNamed(context, '/details', arguments: e), onFavorite: () => vm.toggleFavorite(e.id))).toList()));
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Sobre')), body: const Padding(padding: EdgeInsets.all(16), child: Text('Solar Shield - Global Solution 2026.1 - Turma 3SIZ. Projeto conectado ao tema Space Connect e aos ODS 9 e 13.')));
}
