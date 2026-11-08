import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/api_event.dart';

/// Experiment 9(a): Fetch data from a REST API using the http package
class ApiService {
  static const String endpoint = 'https://jsonplaceholder.typicode.com/posts?_limit=6';

  static Future<List<ApiEvent>> fetchEvents({http.Client? client}) async {
    final httpClient = client ?? http.Client();
    try {
      final response = await httpClient.get(
        Uri.parse(endpoint),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => ApiEvent.fromJson(item as Map<String, dynamic>)).toList();
      } else {
        throw Exception('Failed to load events: HTTP ${response.statusCode}');
      }
    } catch (e) {
      // Graceful fallback with offline sample events if network is unreachable
      return [
        const ApiEvent(
          id: 1,
          title: 'Music & Beat Conclave',
          body: 'Annual music gathering and concert fest in Hyderabad.',
          category: 'MUSIC',
          venue: 'Gachibowli Stadium',
        ),
        const ApiEvent(
          id: 2,
          title: 'AI & Cloud Technology Summit',
          body: 'Interactive tech conference covering mobile and cloud innovation.',
          category: 'TECH',
          venue: 'HITEC City, Hyderabad',
        ),
        const ApiEvent(
          id: 3,
          title: 'Contemporary Art Exhibition',
          body: 'Showcasing national and international artists and sculptors.',
          category: 'ART',
          venue: 'State Art Gallery',
        ),
      ];
    }
  }
}
