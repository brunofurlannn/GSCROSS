import 'package:dio/dio.dart';
import '../model/gst_response_dto.dart';

class NasaApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://api.nasa.gov'));

  Future<List<GstResponseDto>> getGstEvents() async {
    final response = await _dio.get('/DONKI/GST', queryParameters: {
      'startDate': '2026-01-01',
      'endDate': '2026-12-31',
      'api_key': 'DEMO_KEY',
    });
    final data = response.data as List;
    return data.map((json) => GstResponseDto.fromJson(json)).toList();
  }
}
