import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Experiment 10(b): Flutter Debugging Tools, Error Handling & Logging Utility
class AppLogger {
  static void initErrorHandling() {
    // 1. Catch Flutter Framework errors and log with stack trace
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      logError('Flutter Framework Error: ${details.exceptionAsString()}', details.stack);
    };

    // 2. Custom ErrorWidget to replace standard red screen in production
    ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
      return Material(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.deepPurple, size: 48),
                const SizedBox(height: 12),
                const Text(
                  'Eventify encountered an issue',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  kDebugMode ? errorDetails.summary.toString() : 'Please restart the application.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      );
    };
  }

  static void logInfo(String message) {
    if (kDebugMode) {
      debugPrint('[INFO] [Eventify]: $message');
    }
  }

  static void logWarning(String message) {
    if (kDebugMode) {
      debugPrint('[WARN] [Eventify]: $message');
    }
  }

  static void logError(String message, [StackTrace? stack]) {
    if (kDebugMode) {
      debugPrint('[ERROR] [Eventify]: $message');
      if (stack != null) {
        debugPrint(stack.toString());
      }
    }
  }
}
