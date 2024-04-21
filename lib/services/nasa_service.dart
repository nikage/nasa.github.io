import 'package:test_assignment_nasa/data/models/APODModel.dart';
import 'package:test_assignment_nasa/services/http_service.dart';

class NasaService {
  final String baseUrl = 'https://api.nasa.gov/planetary/apod';
  final String apiKey = 'IHE6wfIXbhRbcJKIZQTcJt0MmvCPQffEa3Ox70ey';
  final HttpService _httpService = HttpService(
    baseUrl: 'https://api.nasa.gov',
  );

  Future<APODModel> fetchAPOD({NasaDate? date}) async {
    // TODO: use interceptor or middleware to add the api_key to the request
    String url = '/planetary/apod?date=${date?.value ?? ''}&api_key=$apiKey';

    try {
      final response = await _httpService.get(url);
      return APODModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
  Future<APODModels> fetchAPODRandom({required int count}) async {
    /// count: number of random APOD images to fetch
    /// See: https://api.nasa.gov/?search=APOD
    String url = '/planetary/apod?count=${count}&api_key=$apiKey';

    try {
      final response = await _httpService.get(url);
      return response.map<APODModel>((json) => APODModel.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }
  Future<APODModels> fetchAPODRange({required NasaDate startDate, required NasaDate endDate}) async {
    String url = '/planetary/apod?start_date=$startDate&end_date=$endDate&api_key=$apiKey';

    try {
      final response = await _httpService.get(url);
      return response.map<APODModel>((json) => APODModel.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
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

  factory NasaDate.fromString(String date) {
    final parts = date.split('-');
    // TODO: add validation
    return NasaDate(
      year: int.parse(parts[0]),
      month: int.parse(parts[1]),
      day: int.parse(parts[2]),
    );
  }

  @override
  String toString() {
    return value;
  }
}
