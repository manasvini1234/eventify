import 'package:flutter/material.dart';
import '../widgets/category_chip.dart';
import '../widgets/section_header.dart';
import '../widgets/event_card.dart';

/// Experiment 6(a): Custom Widgets Demonstration Screen
class CustomWidgetsScreen extends StatefulWidget {
  const CustomWidgetsScreen({super.key});

  @override
  State<CustomWidgetsScreen> createState() => _CustomWidgetsScreenState();
}

class _CustomWidgetsScreenState extends State<CustomWidgetsScreen> {
  String _selectedCategory = 'ALL';
  final Set<String> _favorites = {};

  final List<String> _categories = ['ALL', 'MUSIC', 'TECH', 'ART', 'FOOD'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exp 6(a): Custom Reusable Widgets'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Custom SectionHeader Widget
            const SectionHeader(
              title: 'Filter by Category',
              actionText: 'Reset',
            ),
            const SizedBox(height: 8),

            // CustomCategoryChip Widgets row
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _categories.map((cat) {
                  return CustomCategoryChip(
                    label: cat,
                    isSelected: _selectedCategory == cat,
                    onTap: () {
                      setState(() {
                        _selectedCategory = cat;
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),

            const SectionHeader(title: 'Featured Event Cards'),
            const SizedBox(height: 12),

            // Custom EventCard Widget
            SizedBox(
              height: 200,
              child: EventCard(
                title: 'Music Fest 2026',
                category: 'MUSIC',
                date: 'October 18, 2026',
                venue: 'Hyderabad Arena',
                price: '\$40',
                icon: Icons.music_note,
                isFavorite: _favorites.contains('Music Fest 2026'),
                onFavoriteToggle: () {
                  setState(() {
                    if (_favorites.contains('Music Fest 2026')) {
                      _favorites.remove('Music Fest 2026');
                    } else {
                      _favorites.add('Music Fest 2026');
                    }
                  });
                },
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
