import 'package:flutter/material.dart';

/// Experiment 8(b): Experiment with different types of animations (fade, slide, etc.)
class MultiAnimationScreen extends StatefulWidget {
  const MultiAnimationScreen({super.key});

  @override
  State<MultiAnimationScreen> createState() => _MultiAnimationScreenState();
}

class _MultiAnimationScreenState extends State<MultiAnimationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Implicit animation states
  bool _isVisible = true;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    // 1. Fade Animation
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeIn),
    );

    // 2. Slide Animation (slides upward from bottom)
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.4),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic),
    );

    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _replayExplicitAnimations() {
    _animController.reset();
    _animController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exp 8(b): Fade, Slide & Morph Animations'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Explicit Fade & Slide Transitions
            const Text(
              '1. Explicit Slide & Fade Transitions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF512DA8), Color(0xFF673AB7)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.movie_filter, color: Colors.white, size: 36),
                      SizedBox(height: 8),
                      Text(
                        'Smooth Slide & Fade Entrance',
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Transitions run on screen entry or trigger',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: _replayExplicitAnimations,
              icon: const Icon(Icons.replay),
              label: const Text('Replay Slide & Fade'),
            ),
            const SizedBox(height: 24),

            // Section 2: Implicit AnimatedOpacity
            const Text(
              '2. AnimatedOpacity (Fade In / Out)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            AnimatedOpacity(
              opacity: _isVisible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              child: Card(
                color: Colors.amber.shade100,
                child: const ListTile(
                  leading: Icon(Icons.flash_on, color: Colors.amber),
                  title: Text('Flash Pass - Special Offer', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('This card fades in and out smoothly'),
                ),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => setState(() => _isVisible = !_isVisible),
              child: Text(_isVisible ? 'Fade Out Card' : 'Fade In Card'),
            ),
            const SizedBox(height: 24),

            // Section 3: Implicit AnimatedContainer
            const Text(
              '3. AnimatedContainer (Morphing shape & color)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Center(
              child: GestureDetector(
                onTap: () => setState(() => _isExpanded = !_isExpanded),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.fastOutSlowIn,
                  width: _isExpanded ? 240.0 : 120.0,
                  height: _isExpanded ? 100.0 : 70.0,
                  decoration: BoxDecoration(
                    color: _isExpanded ? Colors.teal : Colors.deepPurple,
                    borderRadius: BorderRadius.circular(_isExpanded ? 32 : 12),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    _isExpanded ? 'Tapped (Expanded)' : 'Tap to Morph',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
