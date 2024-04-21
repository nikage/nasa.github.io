import 'package:test_assignment_nasa/services/http_service.dart';

class NasaService {
  final String baseUrl = 'https://api.nasa.gov/planetary/apod';
  final String apiKey = 'IHE6wfIXbhRbcJKIZQTcJt0MmvCPQffEa3Ox70ey';
  final HttpService _httpService = HttpService(
    baseUrl: 'https://api.nasa.gov',
  );

  Future<Map<String, dynamic>> fetchAPOD({NasaDate? date}) async {
    // TODO: use interceptor or middleware to add the api_key to the request
    String url = '/planetary/apod?date=${date?.value ?? ''}&api_key=$apiKey';
    return await _httpService.get(url);
  }
}

class NasaDate {
  final int year;
  final int month;
  final int day;

  NasaDate({
    required this.year,
    required this.month,
    required this.day,
  });

  String get value {
    return '$year-$month-$day';
  }

  factory NasaDate.fromDateTime(DateTime dateTime) {
    return NasaDate(
      year: dateTime.year,
      month: dateTime.month,
      day: dateTime.day,
    );
  }
}