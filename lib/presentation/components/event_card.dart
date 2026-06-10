import 'package:flutter/material.dart';
import '../../domain/model/space_weather_event.dart';

class EventCard extends StatelessWidget {
  final SpaceWeatherEvent event;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavorite;

  const EventCard({super.key, required this.event, required this.isFavorite, required this.onTap, required this.onFavorite});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        onTap: onTap,
        leading: const Icon(Icons.satellite_alt),
        title: Text(event.title),
        subtitle: Text('Kp: ${event.kp} | Risco: ${event.severity}'),
        trailing: IconButton(
          icon: Icon(isFavorite ? Icons.star : Icons.star_border),
          onPressed: onFavorite,
        ),
      ),
    );
  }
}
