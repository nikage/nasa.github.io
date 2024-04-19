import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpService {
  final String baseUrl;
  HttpService({required this.baseUrl});

  Future<dynamic> get(String endpoint) async {
    Uri url = Uri.parse('$baseUrl$endpoint');
    try {
      final response = await http.get(url);
      if (response.statusCode >=  200 && response.statusCode <= 202) {
        return json.decode(response.body);
      } else {
        throw HttpException(
          'Failed to load data from $url',
          statusCode: response.statusCode
        );
      }
    } on http.ClientException catch (e) {
      throw HttpException('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  // TODO: Implement the post, put, and delete methods as needed
}

class HttpException implements Exception {
  final String message;
  final int? statusCode;

  HttpException(this.message, {this.statusCode});

  @override
  String toString() => 'HttpException: $message (Status code: $statusCode)';
}
