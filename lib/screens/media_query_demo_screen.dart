import 'package:flutter/material.dart';
import '../utils/responsive.dart';

/// Experiment 3(b): Implement media queries and breakpoints for responsiveness
class MediaQueryDemoScreen extends StatelessWidget {
  const MediaQueryDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final width = media.size.width;
    final height = media.size.height;
    final orientation = media.orientation;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exp 3(b): Media Queries & Breakpoints'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display live media query values
            Card(
              color: Colors.deepPurple.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Live Device Metrics (MediaQuery)',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const Divider(),
                    Text('Screen Width: ${width.toStringAsFixed(1)} dp'),
                    Text('Screen Height: ${height.toStringAsFixed(1)} dp'),
                    Text('Orientation: ${orientation.name.toUpperCase()}'),
                    Text('Device Pixel Ratio: ${media.devicePixelRatio}'),
                    Text(
                      'Active Breakpoint: ${Responsive.isDesktop(context) ? "DESKTOP (>=1000)" : Responsive.isTablet(context) ? "TABLET (600-999)" : "MOBILE (<600)"}',
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Adaptive UI using Breakpoint builder
            const Text(
              'Adaptive Breakpoint Component:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Responsive(
              mobile: _buildCard('Mobile Layout (<600px)', Colors.teal),
              tablet: _buildCard('Tablet Layout (600px - 999px)', Colors.indigo),
              desktop: _buildCard('Desktop Layout (>=1000px)', Colors.deepPurple),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String text, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color, width: 2),
      ),
      child: Row(
        children: [
          Icon(Icons.devices, color: color, size: 36),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color),
            ),
          ),
        ],
      ),
    );
  }
}
