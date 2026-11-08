import 'package:flutter/material.dart';
import '../models/api_event.dart';
import '../services/api_service.dart';

/// Experiment 9(b): Display fetched REST API data in a meaningful way in the UI
class LiveApiEventsScreen extends StatefulWidget {
  const LiveApiEventsScreen({super.key});

  @override
  State<LiveApiEventsScreen> createState() => _LiveApiEventsScreenState();
}

class _LiveApiEventsScreenState extends State<LiveApiEventsScreen> {
  late Future<List<ApiEvent>> _eventsFuture;

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  void _loadEvents() {
    setState(() {
      _eventsFuture = ApiService.fetchEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exp 9(b): Live REST API Events'),
        actions: [
          IconButton(
            tooltip: 'Refresh',
            icon: const Icon(Icons.refresh),
            onPressed: _loadEvents,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => _loadEvents(),
        child: FutureBuilder<List<ApiEvent>>(
          future: _eventsFuture,
          builder: (context, snapshot) {
            // State 1: Loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Fetching events from REST API...', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              );
            }

            // State 2: Error
            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.cloud_off, size: 64, color: Colors.red),
                      const SizedBox(height: 16),
                      Text(
                        'Failed to load events: ${snapshot.error}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: _loadEvents,
                        icon: const Icon(Icons.replay),
                        label: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              );
            }

            // State 3: Data Empty
            final events = snapshot.data ?? [];
            if (events.isEmpty) {
              return const Center(child: Text('No events found.'));
            }

            // State 4: Data Success - Display in styled list
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.deepPurple.shade50,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.deepPurple.shade200),
                              ),
                              child: Text(
                                event.category,
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              'ID #${event.id}',
                              style: const TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          event.title,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          event.body,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
                        ),
                        const Divider(height: 20),
                        Row(
                          children: [
                            const Icon(Icons.location_on_outlined, size: 16, color: Colors.grey),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                event.venue,
                                style: const TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ),
                            FilledButton.tonal(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Registered for ${event.title}')),
                                );
                              },
                              child: const Text('View'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
