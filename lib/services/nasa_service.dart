import 'package:test_assignment_nasa/services/http_service.dart';

class NasaService {
  final String baseUrl = 'https://api.nasa.gov/planetary/apod';
  final String apiKey = 'IHE6wfIXbhRbcJKIZQTcJt0MmvCPQffEa3Ox70ey';
  final HttpService _httpService = HttpService(
    baseUrl: 'https://api.nasa.gov',
  );

  Future<Map<String, dynamic>> fetchAPOD() async {
    // TODO: use interceptor or middleware to add the api_key to the request
    String url = '/planetary/apod?api_key=$apiKey';
    return await _httpService.get(url);
  }
}

