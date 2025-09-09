import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/env.dart';

class ApiService {
  final String baseUrl = Env.downloaderApiBaseUrl;
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: headers,
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$endpoint'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> downloadFile(String url) async {
    final response = await http.get(Uri.parse(url));
    
    if (response.statusCode == 200) {
      return {
        'success': true,
        'data': response.bodyBytes,
        'contentType': response.headers['content-type'],
      };
    } else {
      throw Exception('Download failed: ${response.statusCode}');
    }
  }
}