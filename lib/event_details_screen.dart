import 'package:flutter/material.dart';
import 'registration_screen.dart';
class EventDetailsScreen extends StatelessWidget {
  final String title;
  final String category;
  final String date;
  final String venue;
  final IconData icon;

  const EventDetailsScreen({
    super.key,
    required this.title,
    required this.category,
    required this.date,
    required this.venue,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                icon,
                size: 90,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              category.toUpperCase(),
              style: const TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.calendar_month),
              title: const Text('Event date'),
              subtitle: Text(date),
            ),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text('Venue'),
              subtitle: Text(venue),
            ),
            const SizedBox(height: 24),
            const Text(
              'About this event',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Join us for $title in $venue. '
              'Discover new experiences, meet people, '
              'and make memorable moments.',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                
onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => RegistrationScreen(
        eventTitle: title,
      ),
    ),
  );
},
                icon: const Icon(Icons.confirmation_num),
                label: const Text('Register for event'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}