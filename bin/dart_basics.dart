// ignore_for_file: avoid_print

/// Experiment 1(b): Simple Dart Program to Understand Language Basics
/// Demonstrates Variables, Functions, OOP, Collections, and Control Flow.
library;

void main() {
  print('=== Dart Language Basics ===\n');

  // 1. Variables and Data Types
  String appName = 'Eventify';
  int totalEvents = 6;
  double ticketPrice = 39.99;
  bool isLive = true;
  print('App Name: $appName | Events: $totalEvents | Starting Price: \$$ticketPrice | Live: $isLive');

  // 2. Collections: List, Set, Map
  List<String> eventNames = ['Music Fest', 'Tech Meetup', 'Art Gala'];
  Set<String> categories = {'MUSIC', 'TECH', 'ART'};
  Map<String, String> eventVenues = {
    'Music Fest': 'Hyderabad Arena',
    'Tech Meetup': 'HITEC City Hall',
  };

  print('\nCategories (Set): $categories');
  print('First Event: ${eventNames.first}');
  print('Venue for Music Fest: ${eventVenues['Music Fest']}');

  // 3. Control Flow & Loops
  print('\nIterating through events:');
  for (var name in eventNames) {
    if (name.contains('Tech')) {
      print(' -> [HIGHLIGHT] $name');
    } else {
      print(' -> $name');
    }
  }

  // 4. Object-Oriented Programming (Class & Object)
  print('\nCreating Event objects using Dart Class:');
  Event sampleEvent = Event(
    id: 101,
    title: 'Flutter Developer Conference',
    venue: 'Gachibowli Convention Center',
    price: 49.50,
  );
  sampleEvent.displayEventDetails();

  // 5. Higher-Order Functions / Lambdas
  var discountedPrices = [20.0, 40.0, 80.0].map((p) => p * 0.9).toList();
  print('\nDiscounted ticket prices (10% off): $discountedPrices');
}

/// A Dart class representing an Event
class Event {
  final int id;
  final String title;
  final String venue;
  final double price;

  Event({
    required this.id,
    required this.title,
    required this.venue,
    required this.price,
  });

  void displayEventDetails() {
    print('Event #$id: $title at $venue (Ticket: \$$price)');
  }
}
