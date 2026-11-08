import 'package:flutter/material.dart';

/// Experiment 5(b): State Management using Provider and ChangeNotifier
class FavoritesProvider extends ChangeNotifier {
  final Set<String> _favorites = {'Music Fest 2026'};

  Set<String> get favorites => Set.unmodifiable(_favorites);

  int get count => _favorites.length;

  bool isFavorite(String title) => _favorites.contains(title);

  void toggleFavorite(String title) {
    if (_favorites.contains(title)) {
      _favorites.remove(title);
    } else {
      _favorites.add(title);
    }
    // notifyListeners notifies all Consumers/listeners to rebuild
    notifyListeners();
  }

  void clearFavorites() {
    _favorites.clear();
    notifyListeners();
  }
}
