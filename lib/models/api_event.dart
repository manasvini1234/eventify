/// Experiment 9(a): Event Data Model with JSON serialization
class ApiEvent {
  final int id;
  final String title;
  final String body;
  final String category;
  final String venue;

  const ApiEvent({
    required this.id,
    required this.title,
    required this.body,
    required this.category,
    required this.venue,
  });

  factory ApiEvent.fromJson(Map<String, dynamic> json) {
    return ApiEvent(
      id: json['id'] as int? ?? 1,
      title: json['title'] as String? ?? 'Featured Event',
      body: json['body'] as String? ?? 'Experience live events with Eventify.',
      category: 'LIVE API',
      venue: 'Convention Hub, Hyderabad',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'category': category,
      'venue': venue,
    };
  }
}
