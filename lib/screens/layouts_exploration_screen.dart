import 'package:flutter/material.dart';

/// Experiment 2(b): Implement layout structures using Row, Column, and Stack widgets
class LayoutsExplorationScreen extends StatelessWidget {
  const LayoutsExplorationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exp 2(b): Row, Column & Stack Layouts'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Column layout (Vertical arrangement)
            const Text(
              '1. Column Layout (Vertical Structure)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Item 1: Event Title', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text('Item 2: Hyderabad Convention Centre', style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 4),
                  Text('Item 3: October 25, 2026', style: TextStyle(color: Colors.deepPurple)),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Section 2: Row Layout (Horizontal with Expanded and Spacer)
            const Text(
              '2. Row Layout (Horizontal Alignment)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.deepPurple,
                    child: Icon(Icons.music_note, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Music Fest 2026', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('Row with Expanded Child', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                  FilledButton.tonal(
                    onPressed: () {},
                    child: const Text('Book'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Section 3: Stack Layout with Positioned Elements
            const Text(
              '3. Stack Layout (Overlapping Widgets)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 180,
              width: double.infinity,
              child: Stack(
                children: [
                  // Base background container
                  Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF311B92), Color(0xFF7E57C2)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.bottomLeft,
                    child: const Text(
                      'Grand Gala Night\nStack Base Container',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  // Positioned badge at top-left
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'FEATURED',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                      ),
                    ),
                  ),
                  // Positioned favorite icon at top-right
                  Positioned(
                    top: 12,
                    right: 12,
                    child: IconButton.filledTonal(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite, color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
