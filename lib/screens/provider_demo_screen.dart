import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';

/// Experiment 5(b): Implement state management using setState and Provider
class ProviderDemoScreen extends StatelessWidget {
  const ProviderDemoScreen({super.key});

  final List<String> sampleEvents = const [
    'Music Fest 2026',
    'Tech Innovators Meetup',
    'Art & Culture Night',
    'Startup Pitch Summit',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exp 5(b): Provider State Management'),
        actions: [
          // Consumer listening specifically to the favorites count
          Consumer<FavoritesProvider>(
            builder: (context, favProvider, child) {
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Center(
                  child: Badge(
                    label: Text('${favProvider.count}'),
                    child: const Icon(Icons.favorite),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: sampleEvents.length,
        itemBuilder: (context, index) {
          final event = sampleEvents[index];

          // Rebuilds only when the state of FavoritesProvider changes
          return Consumer<FavoritesProvider>(
            builder: (context, favProvider, child) {
              final isFav = favProvider.isFavorite(event);

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.deepPurple.shade50,
                    child: const Icon(Icons.event, color: Colors.deepPurple),
                  ),
                  title: Text(event, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(isFav ? 'In Favorites (Provider managed)' : 'Tap to add to favorites'),
                  trailing: IconButton(
                    icon: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: isFav ? Colors.red : null,
                    ),
                    onPressed: () {
                      favProvider.toggleFavorite(event);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
