import 'package:flutter/material.dart';

/// Experiment 5(a): Learn about Stateful and Stateless Widgets
class StateComparisonScreen extends StatelessWidget {
  const StateComparisonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exp 5(a): Stateful vs Stateless'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Stateless Widget Example (Immutable UI)
            StatelessEventBanner(
              title: 'Stateless Widget Demo',
              description: 'This widget is immutable and has no internal mutable state.',
            ),
            SizedBox(height: 24),

            // 2. Stateful Widget Example (Interactive Mutable UI)
            StatefulFavoriteTracker(
              eventTitle: 'Music Fest 2026',
            ),
            SizedBox(height: 24),

            // 3. Stateful Ticket Counter Example
            StatefulTicketCounter(),
          ],
        ),
      ),
    );
  }
}

/// Example of a Stateless Widget:
/// Properties are final and the widget never rebuilds unless new properties are passed.
class StatelessEventBanner extends StatelessWidget {
  final String title;
  final String description;

  const StatelessEventBanner({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.deepPurple.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.info_outline, color: Colors.deepPurple),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(description, style: TextStyle(color: Colors.grey.shade700)),
        ],
      ),
    );
  }
}

/// Example of a Stateful Widget:
/// Maintains mutable state (_isFavorite) across user interactions.
class StatefulFavoriteTracker extends StatefulWidget {
  final String eventTitle;

  const StatefulFavoriteTracker({super.key, required this.eventTitle});

  @override
  State<StatefulFavoriteTracker> createState() => _StatefulFavoriteTrackerState();
}

class _StatefulFavoriteTrackerState extends State<StatefulFavoriteTracker> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.music_note, color: Colors.deepPurple),
        title: Text(widget.eventTitle, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(_isFavorite ? 'Saved to Favorites' : 'Tap heart to bookmark'),
        trailing: IconButton(
          icon: Icon(
            _isFavorite ? Icons.favorite : Icons.favorite_border,
            color: _isFavorite ? Colors.red : null,
          ),
          onPressed: () {
            // setState triggers a rebuild of the widget subtree
            setState(() {
              _isFavorite = !_isFavorite;
            });
          },
        ),
      ),
    );
  }
}

/// Another Stateful Widget: Ticket counter increment/decrement
class StatefulTicketCounter extends StatefulWidget {
  const StatefulTicketCounter({super.key});

  @override
  State<StatefulTicketCounter> createState() => _StatefulTicketCounterState();
}

class _StatefulTicketCounterState extends State<StatefulTicketCounter> {
  int _count = 1;
  final int _unitPrice = 35;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Tickets Selected:', style: TextStyle(fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    IconButton.filledTonal(
                      onPressed: _count > 1 ? () => setState(() => _count--) : null,
                      icon: const Icon(Icons.remove),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text('$_count', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    IconButton.filledTonal(
                      onPressed: () => setState(() => _count++),
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Amount:', style: TextStyle(fontSize: 16)),
                Text(
                  '\$${_count * _unitPrice}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
