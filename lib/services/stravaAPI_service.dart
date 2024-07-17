import 'dart:convert';
import 'package:http/http.dart' as http;

class StravaApiService {
  final String baseUrl = 'https://www.strava.com/api/v3';
  final String accessToken;

  StravaApiService({required this.accessToken});

  Future<List<dynamic>> getActivities() async {
    final url = Uri.parse('$baseUrl/activities/');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load activities');
    }
  }
}
