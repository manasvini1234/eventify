import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

/// Experiment 4(b): Navigation with Named Routes
class EventListScreen extends StatelessWidget {
  const EventListScreen({super.key});

  final List<Map<String, String>> events = const [
    {
      'title': 'Music Fest 2026',
      'category': 'MUSIC',
      'date': 'October 18, 2026',
      'venue': 'Hyderabad Arena',
      'price': '\$40',
    },
    {
      'title': 'Tech Innovators Meetup',
      'category': 'TECHNOLOGY',
      'date': 'October 22, 2026',
      'venue': 'HITEC City',
      'price': 'Free',
    },
    {
      'title': 'Art & Culture Night',
      'category': 'ART',
      'date': 'October 25, 2026',
      'venue': 'Jubilee Hills',
      'price': '\$20',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exp 4(b): Named Routes Navigation'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.deepPurple.shade50,
                child: const Icon(Icons.event, color: Colors.deepPurple),
              ),
              title: Text(event['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${event['date']} • ${event['venue']}'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Navigate using Named Route with arguments
                Navigator.pushNamed(
                  context,
                  AppRoutes.details,
                  arguments: event,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
