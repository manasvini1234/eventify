import 'package:flutter/material.dart';

/// Experiment 3(a): Design a responsive UI that adapts to different screen sizes
class ResponsiveGridScreen extends StatelessWidget {
  const ResponsiveGridScreen({super.key});

  final List<String> events = const [
    'Music Fest 2026',
    'Tech Innovators Meetup',
    'Art & Culture Night',
    'Startup Pitch Summit',
    'Global Food Carnival',
    'Marathon & Fitness Run',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exp 3(a): Responsive UI Design'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Adaptive column count based on available screen width
          final int crossAxisCount = constraints.maxWidth >= 900
              ? 3 // Desktop / Wide screen
              : constraints.maxWidth >= 600
                  ? 2 // Tablet
                  : 1; // Mobile

          final double horizontalPadding = constraints.maxWidth >= 600 ? 32.0 : 16.0;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Responsive View (${constraints.maxWidth.toInt()}px width - $crossAxisCount columns)',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple.shade700,
                  ),
                ),
                const SizedBox(height: 12),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: events.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    mainAxisExtent: 130,
                  ),
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.deepPurple.shade100,
                              child: Text('${index + 1}'),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    events[index],
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    'Responsive Card item',
                                    style: TextStyle(color: Colors.grey, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
