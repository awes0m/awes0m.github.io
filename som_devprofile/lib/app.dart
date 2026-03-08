import 'package:flutter/material.dart';

import 'src/sidebar/sidebar_card.dart';
import 'src/content/content_card.dart';
import 'src/navigation/tab_nav_bar.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedTab = 0;

  void _onTabSelected(int index) {
    setState(() => _selectedTab = index);
  }

  static const double _breakpoint = 1000.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isDesktop = constraints.maxWidth >= _breakpoint;

        if (isDesktop) {
          return _buildDesktop(context);
        } else {
          return _buildMobile(context);
        }
      },
    );
  }

  // ────────────────────────────── DESKTOP ──────────────────────────────────
  Widget _buildDesktop(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left sticky sidebar – fixed 270px, scrolls independently
              const SizedBox(
                width: 270,
                child: SidebarCard(isMobile: false),
              ),
              // Right content card – takes the rest
              Expanded(
                child: ContentCard(
                  key: const ValueKey('content-desktop'),
                  selectedIndex: _selectedTab,
                  onTabSelected: _onTabSelected,
                  isDesktop: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ────────────────────────────── MOBILE ───────────────────────────────────
  Widget _buildMobile(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar: TabNavBar(
        selectedIndex: _selectedTab,
        onTabSelected: _onTabSelected,
        isDesktop: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Collapsed sidebar header with profile info
          const SidebarCard(isMobile: true),
          // Content card fills remaining space
          Expanded(
            child: ContentCard(
              key: const ValueKey('content-mobile'),
              selectedIndex: _selectedTab,
              onTabSelected: _onTabSelected,
              isDesktop: false,
            ),
          ),
        ],
      ),
    );
  }
}
