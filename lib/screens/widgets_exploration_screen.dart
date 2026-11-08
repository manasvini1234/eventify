import 'package:flutter/material.dart';

/// Experiment 2(a): Explore various Flutter widgets (Text, Image, Container, etc.)
class WidgetsExplorationScreen extends StatelessWidget {
  const WidgetsExplorationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exp 2(a): Flutter Core Widgets'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Text Widget with rich formatting
            const Text(
              '1. Text Widget Exploration',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Welcome to Eventify: Discover Experiences',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.deepPurple.shade700,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 20),

            // 2. Container Widget with Box Decoration (Border, Gradient, Shadow)
            const Text(
              '2. Container Widget with Decoration',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple.shade600, Colors.purple.shade300],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurple.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Text(
                'Styled Container: Gradient, Rounded Corners & Drop Shadow',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            const SizedBox(height: 20),

            // 3. Icons and Image Exploration
            const Text(
              '3. Icon & Image Widgets',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.deepPurple.shade200),
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.celebration, size: 48, color: Colors.deepPurple),
                    SizedBox(height: 6),
                    Text(
                      'Visual Image/Icon Placeholder for Event Assets',
                      style: TextStyle(color: Colors.deepPurple),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 4. Buttons and Interactive Widgets
            const Text(
              '4. Interactive Button Widgets',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.explore),
                  label: const Text('Explore Events'),
                ),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.bookmark_border),
                  label: const Text('Bookmarks'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
