import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:eventify_app/widgets/event_card.dart';
import 'package:eventify_app/main.dart';

/// Experiment 10(a): Widget Tests for UI Components
void main() {
  group('Experiment 10(a): Widget Testing Suite', () {
    testWidgets('EventCard displays details and handles taps', (WidgetTester tester) async {
      bool tapped = false;
      bool favToggled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EventCard(
              title: 'Art & Culture Night',
              category: 'ART',
              date: 'October 25, 2026',
              venue: 'Jubilee Hills',
              price: '\$20',
              icon: Icons.palette,
              isFavorite: false,
              onFavoriteToggle: () => favToggled = true,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      // Verify that title and category are rendered
      expect(find.text('Art & Culture Night'), findsOneWidget);
      expect(find.text('ART'), findsOneWidget);
      expect(find.text('Jubilee Hills'), findsOneWidget);

      // Tap card
      await tester.tap(find.text('Art & Culture Night'));
      expect(tapped, isTrue);

      // Tap favorite button
      await tester.tap(find.byIcon(Icons.favorite_border));
      expect(favToggled, isTrue);
    });

    testWidgets('EventifyApp smoke test renders App Bar and home title', (WidgetTester tester) async {
      await tester.pumpWidget(const EventifyApp());
      expect(find.text('Eventify'), findsOneWidget);
      expect(find.text('Discover events'), findsOneWidget);
    });
  });
}
