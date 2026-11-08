import 'package:flutter/material.dart';

/// Experiment 8(a): Add animations using Flutter's animation framework
class AnimationControllerScreen extends StatefulWidget {
  const AnimationControllerScreen({super.key});

  @override
  State<AnimationControllerScreen> createState() => _AnimationControllerScreenState();
}

class _AnimationControllerScreenState extends State<AnimationControllerScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    // Initialize AnimationController with 2 seconds duration
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    // Curved Animation for smooth scaling
    _scaleAnimation = Tween<double>(begin: 0.85, end: 1.15).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _rotationAnimation = Tween<double>(begin: -0.05, end: 0.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Repeat animation back and forth
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exp 8(a): Animation Controller'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Event Hero Badge Animation',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Driven by AnimationController with CurvedAnimation',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 40),

              // Animated Widget with Scale & Rotation Transitions
              RotationTransition(
                turns: _rotationAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    width: 170,
                    height: 170,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.deepPurple, Colors.purpleAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.deepPurple.withValues(alpha: 0.4),
                          blurRadius: 20,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.celebration, size: 54, color: Colors.white),
                          SizedBox(height: 6),
                          Text(
                            'EVENTIFY',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),

              // Animation Controls
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      if (_controller.isAnimating) {
                        _controller.stop();
                      } else {
                        _controller.repeat(reverse: true);
                      }
                      setState(() {});
                    },
                    icon: Icon(_controller.isAnimating ? Icons.pause : Icons.play_arrow),
                    label: Text(_controller.isAnimating ? 'Pause' : 'Play'),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton.icon(
                    onPressed: () {
                      _controller.reset();
                      setState(() {});
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reset'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
