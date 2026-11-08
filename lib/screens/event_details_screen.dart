import 'package:flutter/material.dart';

/// Experiment 4(a): Event Details Screen accessed via Navigator.push
class EventDetailsScreen extends StatelessWidget {
  final String title;
  final String category;
  final String date;
  final String venue;
  final String price;

  const EventDetailsScreen({
    super.key,
    required this.title,
    required this.category,
    required this.date,
    required this.venue,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigator.pop returns to the previous screen
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.deepPurple, Colors.indigo],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.event, size: 72, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Text(
              category,
              style: const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.calendar_today, color: Colors.deepPurple),
              title: const Text('Date & Time'),
              subtitle: Text(date),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.location_on, color: Colors.deepPurple),
              title: const Text('Venue Location'),
              subtitle: Text(venue),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.attach_money, color: Colors.deepPurple),
              title: const Text('Ticket Price'),
              subtitle: Text(price),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Selected: $title')),
                  );
                },
                icon: const Icon(Icons.confirmation_num),
                label: const Text('Proceed to Registration'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
