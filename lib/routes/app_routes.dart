import 'package:flutter/material.dart';
import '../screens/event_details_screen.dart';
import '../screens/widgets_exploration_screen.dart';
import '../screens/layouts_exploration_screen.dart';
import '../screens/responsive_grid_screen.dart';
import '../screens/media_query_demo_screen.dart';
import '../screens/state_comparison_screen.dart';
import '../screens/provider_demo_screen.dart';
import '../screens/custom_widgets_screen.dart';
import '../screens/theme_demo_screen.dart';
import '../screens/registration_form_screen.dart';
import '../screens/validated_registration_screen.dart';
import '../screens/animation_controller_screen.dart';
import '../screens/multi_animation_screen.dart';
import '../screens/live_api_events_screen.dart';
import '../main.dart';

/// Experiment 4(b) & 10(b): Complete Named Routing Table for All Experiments
class AppRoutes {
  static const String home = '/';
  static const String details = '/details';
  static const String widgets = '/widgets';
  static const String layouts = '/layouts';
  static const String responsive = '/responsive';
  static const String mediaQuery = '/media_query';
  static const String stateComparison = '/state_comparison';
  static const String providerDemo = '/provider_demo';
  static const String customWidgets = '/custom_widgets';
  static const String themeDemo = '/theme_demo';
  static const String formInputs = '/form_inputs';
  static const String formValidation = '/form_validation';
  static const String animationController = '/animation_controller';
  static const String multiAnimation = '/multi_animation';
  static const String liveApi = '/live_api';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const EventifyHomePage());

      case details:
        if (settings.arguments is Map<String, String>) {
          final args = settings.arguments as Map<String, String>;
          return MaterialPageRoute(
            builder: (_) => EventDetailsScreen(
              title: args['title'] ?? 'Event',
              category: args['category'] ?? 'General',
              date: args['date'] ?? 'TBA',
              venue: args['venue'] ?? 'TBA',
              price: args['price'] ?? 'Free',
            ),
          );
        }
        return MaterialPageRoute(
          builder: (_) => const EventDetailsScreen(
            title: 'Sample Event',
            category: 'GENERAL',
            date: 'October 25, 2026',
            venue: 'Hyderabad',
            price: '\$20',
          ),
        );

      case widgets:
        return MaterialPageRoute(builder: (_) => const WidgetsExplorationScreen());
      case layouts:
        return MaterialPageRoute(builder: (_) => const LayoutsExplorationScreen());
      case responsive:
        return MaterialPageRoute(builder: (_) => const ResponsiveGridScreen());
      case mediaQuery:
        return MaterialPageRoute(builder: (_) => const MediaQueryDemoScreen());
      case stateComparison:
        return MaterialPageRoute(builder: (_) => const StateComparisonScreen());
      case providerDemo:
        return MaterialPageRoute(builder: (_) => const ProviderDemoScreen());
      case customWidgets:
        return MaterialPageRoute(builder: (_) => const CustomWidgetsScreen());
      case themeDemo:
        return MaterialPageRoute(
          builder: (_) => ThemeDemoScreen(isDark: false, onToggleTheme: () {}),
        );
      case formInputs:
        return MaterialPageRoute(builder: (_) => const RegistrationFormScreen());
      case formValidation:
        return MaterialPageRoute(builder: (_) => const ValidatedRegistrationScreen());
      case animationController:
        return MaterialPageRoute(builder: (_) => const AnimationControllerScreen());
      case multiAnimation:
        return MaterialPageRoute(builder: (_) => const MultiAnimationScreen());
      case liveApi:
        return MaterialPageRoute(builder: (_) => const LiveApiEventsScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Route Error')),
            body: Center(child: Text('Route ${settings.name} not found!')),
          ),
        );
    }
  }
}
