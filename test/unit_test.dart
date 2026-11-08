import 'package:flutter_test/flutter_test.dart';
import 'package:eventify_app/models/api_event.dart';
import 'package:eventify_app/providers/favorites_provider.dart';

/// Experiment 10(a): Unit tests for Models and State Management Providers
void main() {
  group('Experiment 10(a): Unit Testing Suite', () {
    test('ApiEvent model parses from JSON accurately', () {
      final jsonMap = {
        'id': 42,
        'title': 'Flutter Developers Summit',
        'body': 'Deep dive into Flutter and Dart.',
      };

      final event = ApiEvent.fromJson(jsonMap);

      expect(event.id, equals(42));
      expect(event.title, equals('Flutter Developers Summit'));
      expect(event.category, equals('LIVE API'));
    });

    test('FavoritesProvider toggles and counts favorites correctly', () {
      final provider = FavoritesProvider();

      // Initial state contains 1 favorite ('Music Fest 2026')
      expect(provider.isFavorite('Music Fest 2026'), isTrue);
      expect(provider.count, equals(1));

      // Add a new favorite
      provider.toggleFavorite('Tech Meetup');
      expect(provider.isFavorite('Tech Meetup'), isTrue);
      expect(provider.count, equals(2));

      // Remove the favorite
      provider.toggleFavorite('Tech Meetup');
      expect(provider.isFavorite('Tech Meetup'), isFalse);
      expect(provider.count, equals(1));
    });
  });
}
