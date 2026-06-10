class GstResponseDto {
  final String gstID;
  final String startTime;
  final String link;
  final double kpIndex;

  GstResponseDto({
    required this.gstID,
    required this.startTime,
    required this.link,
    required this.kpIndex,
  });

  factory GstResponseDto.fromJson(Map<String, dynamic> json) {
    final kpList = (json['allKpIndex'] as List?) ?? [];
    final kp = kpList.isNotEmpty ? (kpList.first['kpIndex'] ?? 0).toDouble() : 0.0;
    return GstResponseDto(
      gstID: json['gstID'] ?? 'GST-SEM-ID',
      startTime: json['startTime'] ?? '',
      link: json['link'] ?? '',
      kpIndex: kp,
    );
  }
}
