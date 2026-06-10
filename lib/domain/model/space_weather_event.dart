class SpaceWeatherEvent {
  final String id;
  final String title;
  final String startTime;
  final double kp;
  final String severity;
  final bool emergencyNotification;
  final String link;

  SpaceWeatherEvent({
    required this.id,
    required this.title,
    required this.startTime,
    required this.kp,
    required this.severity,
    required this.emergencyNotification,
    required this.link,
  });
}
