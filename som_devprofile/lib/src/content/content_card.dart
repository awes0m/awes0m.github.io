import 'package:flutter/material.dart';

import '../navigation/tab_nav_bar.dart';
import '../../tabs/tabs.dart';
import 'about_tab.dart';

/// The right-hand content card.
/// Shows the active tab's content and hosts the TabNavBar in its header (desktop)
/// or connects to the bottom TabNavBar provided by the shell (mobile).
class ContentCard extends StatelessWidget {
  const ContentCard({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
    required this.isDesktop,
  });

  final int selectedIndex;
  final ValueChanged<int> onTabSelected;
  final bool isDesktop;

  static final List<Widget> _tabBodies = [
    const AboutTab(),
    WhatIdo(),
    Education(),
    Experience(),
    Projects(),
    Certifications(),
    const ContactMe(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: isDesktop
          ? const EdgeInsets.fromLTRB(8, 16, 16, 16)
          : const EdgeInsets.fromLTRB(12, 8, 12, 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 24,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Header bar ──────────────────────────────
            _buildHeader(context, theme),
            // ── Content ─────────────────────────────────
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 280),
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.easeOut,
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                child: KeyedSubtree(
                  key: ValueKey<int>(selectedIndex),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: _tabBodies[selectedIndex],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ThemeData theme) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 20 : 14,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.outline.withValues(alpha: 0.15),
          ),
        ),
      ),
      child: isDesktop
          ? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TabNavBar(
                  selectedIndex: selectedIndex,
                  onTabSelected: onTabSelected,
                  isDesktop: true,
                ),
              ],
            )
          : Align(
              alignment: Alignment.centerLeft,
              child: Text(
                _currentTabName(selectedIndex),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
    );
  }

  String _currentTabName(int index) {
    const names = [
      'About',
      'What I Do',
      'Education',
      'Experience',
      'Projects',
      'Certifications',
      'Contact Me',
    ];
    return index < names.length ? names[index] : '';
  }
}
