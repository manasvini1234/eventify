import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme/app_theme.dart';
import 'routes/app_routes.dart';
import 'providers/favorites_provider.dart';
import 'utils/app_logger.dart';
import 'widgets/event_card.dart';
import 'widgets/category_chip.dart';
import 'widgets/section_header.dart';

void main() {
  // Experiment 10(b): Initialize error handling & debugging logger
  AppLogger.initErrorHandling();
  AppLogger.logInfo('Eventify application initialized.');

  runApp(const EventifyApp());
}

/// Main Eventify Application Container
class EventifyApp extends StatelessWidget {
  const EventifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FavoritesProvider(),
      child: MaterialApp(
        title: 'Eventify',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        initialRoute: AppRoutes.home,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}

class EventifyHomePage extends StatefulWidget {
  const EventifyHomePage({super.key});

  @override
  State<EventifyHomePage> createState() => _EventifyHomePageState();
}

class _EventifyHomePageState extends State<EventifyHomePage> {
  int _selectedIndex = 0;
  String _searchQuery = '';
  String _selectedCategory = 'ALL';

  final List<Map<String, String>> _events = [
    {
      'title': 'Music Fest 2026',
      'category': 'MUSIC',
      'date': 'October 18, 2026',
      'venue': 'Hyderabad Arena',
      'price': '\$40',
      'icon': 'music',
    },
    {
      'title': 'Tech Innovators Meetup',
      'category': 'TECHNOLOGY',
      'date': 'October 22, 2026',
      'venue': 'HITEC City',
      'price': 'Free',
      'icon': 'tech',
    },
    {
      'title': 'Art & Culture Night',
      'category': 'ART',
      'date': 'October 25, 2026',
      'venue': 'Jubilee Hills',
      'price': '\$20',
      'icon': 'art',
    },
    {
      'title': 'Startup Pitch Summit',
      'category': 'BUSINESS',
      'date': 'November 05, 2026',
      'venue': 'Gachibowli',
      'price': '\$50',
      'icon': 'business',
    },
    {
      'title': 'Global Food Carnival',
      'category': 'FOOD',
      'date': 'November 12, 2026',
      'venue': 'Banjara Hills',
      'price': '\$15',
      'icon': 'food',
    },
    {
      'title': 'City Marathon & Fitness Run',
      'category': 'SPORTS',
      'date': 'November 20, 2026',
      'venue': 'Necklace Road',
      'price': '\$30',
      'icon': 'sports',
    },
  ];

  final List<String> _categories = [
    'ALL',
    'MUSIC',
    'TECHNOLOGY',
    'ART',
    'BUSINESS',
    'FOOD',
    'SPORTS',
  ];

  IconData _getIcon(String? type) {
    switch (type) {
      case 'music':
        return Icons.music_note;
      case 'tech':
        return Icons.computer;
      case 'art':
        return Icons.palette;
      case 'business':
        return Icons.trending_up;
      case 'food':
        return Icons.restaurant;
      case 'sports':
        return Icons.directions_run;
      default:
        return Icons.event;
    }
  }

  List<Map<String, String>> get _filteredEvents {
    return _events.where((event) {
      final matchesSearch =
          event['title']!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              event['venue']!.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCat = _selectedCategory == 'ALL' ||
          event['category']!.toUpperCase() == _selectedCategory;
      return matchesSearch && matchesCat;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eventify', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            tooltip: 'Live REST API Events',
            icon: const Icon(Icons.cloud_sync),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.liveApi),
          ),
          IconButton(
            tooltip: 'Registration',
            icon: const Icon(Icons.how_to_reg),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.formValidation),
          ),
        ],
      ),
      drawer: _buildExperimentsDrawer(context),
      body: _buildTabBody(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (idx) => setState(() => _selectedIndex = idx),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_outline),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          NavigationDestination(
            icon: Icon(Icons.confirmation_num_outlined),
            selectedIcon: Icon(Icons.confirmation_num),
            label: 'Bookings',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildTabBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildExploreTab();
      case 1:
        return _buildFavoritesTab();
      case 2:
        return _buildBookingsTab();
      case 3:
        return _buildProfileTab();
      default:
        return _buildExploreTab();
    }
  }

  Widget _buildExploreTab() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 900
            ? 3
            : constraints.maxWidth >= 600
                ? 2
                : 1;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Discover events',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                'Find experiences worth remembering.',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 15),
              ),
              const SizedBox(height: 16),

              // Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF512DA8), Color(0xFF7E57C2)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.celebration, color: Colors.white, size: 36),
                    SizedBox(height: 8),
                    Text(
                      'Make every moment count!',
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Explore events. Meet people. Create memories.',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Search Input
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search by title or venue...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () => setState(() => _searchQuery = ''),
                        )
                      : null,
                ),
                onChanged: (val) => setState(() => _searchQuery = val.trim()),
              ),
              const SizedBox(height: 16),

              // Category Filter Chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _categories.map((cat) {
                    return CustomCategoryChip(
                      label: cat,
                      isSelected: _selectedCategory == cat,
                      onTap: () => setState(() => _selectedCategory = cat),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),

              SectionHeader(
                title: 'Upcoming events',
                actionText: '${_filteredEvents.length} events',
              ),
              const SizedBox(height: 12),

              // Events Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _filteredEvents.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  mainAxisExtent: 220,
                ),
                itemBuilder: (context, index) {
                  final event = _filteredEvents[index];
                  final title = event['title']!;

                  return Consumer<FavoritesProvider>(
                    builder: (context, favProvider, child) {
                      final isFav = favProvider.isFavorite(title);
                      return EventCard(
                        title: title,
                        category: event['category']!,
                        date: event['date']!,
                        venue: event['venue']!,
                        price: event['price']!,
                        icon: _getIcon(event['icon']),
                        isFavorite: isFav,
                        onFavoriteToggle: () => favProvider.toggleFavorite(title),
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.details, arguments: event);
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFavoritesTab() {
    return Consumer<FavoritesProvider>(
      builder: (context, favProvider, child) {
        final favList = _events.where((e) => favProvider.isFavorite(e['title']!)).toList();

        if (favList.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.favorite_outline, size: 64, color: Colors.grey),
                SizedBox(height: 12),
                Text('No favorite events saved yet', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: favList.length,
          itemBuilder: (context, index) {
            final event = favList[index];
            final title = event['title']!;
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.deepPurple.shade50,
                  child: Icon(_getIcon(event['icon']), color: Colors.deepPurple),
                ),
                title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('${event['date']} • ${event['venue']}'),
                trailing: IconButton(
                  icon: const Icon(Icons.favorite, color: Colors.red),
                  onPressed: () => favProvider.toggleFavorite(title),
                ),
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.details, arguments: event);
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildBookingsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text('CONFIRMED', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                    ),
                    const Text('Pass #EVT-2026', style: TextStyle(color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 12),
                const Text('Tech Innovators Meetup', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const Text('Date: October 22, 2026 • HITEC City'),
                const Divider(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.qr_code, size: 28, color: Colors.deepPurple),
                        SizedBox(width: 8),
                        Text('Show pass at venue entry'),
                      ],
                    ),
                    FilledButton.tonal(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Displaying entry QR pass.')),
                        );
                      },
                      child: const Text('View Pass'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 44,
            backgroundColor: Colors.deepPurple,
            child: Text('MV', style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 12),
          const Text('Manasvini Vandanapu', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Text('manasvinivandanapu@gmail.com', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          Consumer<FavoritesProvider>(
            builder: (context, favProvider, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _statItem('Attended', '4'),
                  _statItem('Bookings', '1'),
                  _statItem('Favorites', '${favProvider.count}'),
                ],
              );
            },
          ),
          const Divider(height: 32),
          ListTile(
            leading: const Icon(Icons.school_outlined),
            title: const Text('Lab Experiments Hub'),
            subtitle: const Text('Launch all 10 syllabus experiments'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Scaffold.of(context).openDrawer(),
          ),
          ListTile(
            leading: const Icon(Icons.cloud_download_outlined),
            title: const Text('Live REST API Events'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.pushNamed(context, AppRoutes.liveApi),
          ),
          ListTile(
            leading: const Icon(Icons.animation),
            title: const Text('UI Animations Showcase'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.pushNamed(context, AppRoutes.multiAnimation),
          ),
        ],
      ),
    );
  }

  Widget _statItem(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildExperimentsDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.deepPurple),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Eventify Lab Manual', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                Text('MAD Lab Experiments (1 to 10)', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.widgets),
            title: const Text('Exp 2(a): Core Widgets'),
            onTap: () => Navigator.pushNamed(context, AppRoutes.widgets),
          ),
          ListTile(
            leading: const Icon(Icons.view_quilt),
            title: const Text('Exp 2(b): Row, Column & Stack'),
            onTap: () => Navigator.pushNamed(context, AppRoutes.layouts),
          ),
          ListTile(
            leading: const Icon(Icons.aspect_ratio),
            title: const Text('Exp 3(a): Responsive Grid'),
            onTap: () => Navigator.pushNamed(context, AppRoutes.responsive),
          ),
          ListTile(
            leading: const Icon(Icons.devices),
            title: const Text('Exp 3(b): Media Queries'),
            onTap: () => Navigator.pushNamed(context, AppRoutes.mediaQuery),
          ),
          ListTile(
            leading: const Icon(Icons.sync_alt),
            title: const Text('Exp 5(a): State Comparison'),
            onTap: () => Navigator.pushNamed(context, AppRoutes.stateComparison),
          ),
          ListTile(
            leading: const Icon(Icons.account_tree),
            title: const Text('Exp 5(b): Provider Management'),
            onTap: () => Navigator.pushNamed(context, AppRoutes.providerDemo),
          ),
          ListTile(
            leading: const Icon(Icons.design_services),
            title: const Text('Exp 6(a): Custom Widgets'),
            onTap: () => Navigator.pushNamed(context, AppRoutes.customWidgets),
          ),
          ListTile(
            leading: const Icon(Icons.palette),
            title: const Text('Exp 6(b): Theming & Styles'),
            onTap: () => Navigator.pushNamed(context, AppRoutes.themeDemo),
          ),
          ListTile(
            leading: const Icon(Icons.input),
            title: const Text('Exp 7(a): Form Inputs'),
            onTap: () => Navigator.pushNamed(context, AppRoutes.formInputs),
          ),
          ListTile(
            leading: const Icon(Icons.verified),
            title: const Text('Exp 7(b): Form Validation'),
            onTap: () => Navigator.pushNamed(context, AppRoutes.formValidation),
          ),
          ListTile(
            leading: const Icon(Icons.rotate_right),
            title: const Text('Exp 8(a): Animation Controller'),
            onTap: () => Navigator.pushNamed(context, AppRoutes.animationController),
          ),
          ListTile(
            leading: const Icon(Icons.animation),
            title: const Text('Exp 8(b): Multi-Animation'),
            onTap: () => Navigator.pushNamed(context, AppRoutes.multiAnimation),
          ),
          ListTile(
            leading: const Icon(Icons.cloud),
            title: const Text('Exp 9(b): Live REST API'),
            onTap: () => Navigator.pushNamed(context, AppRoutes.liveApi),
          ),
        ],
      ),
    );
  }
}
