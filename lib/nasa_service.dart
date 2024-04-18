import 'dart:convert';
import 'package:http/http.dart' as http;

class NasaService {
  final String baseUrl = 'https://api.nasa.gov/planetary/apod';
  final String apiKey = 'IHE6wfIXbhRbcJKIZQTcJt0MmvCPQffEa3Ox70ey';

  Future<Map<String, dynamic>> fetchAPOD() async {
    try {
      final url = Uri.parse('$baseUrl?api_key=$apiKey');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Failed to load APOD data');
      }
    } catch (e) {
      throw Exception('Failed to load APOD data: $e');
    }
  }
}
