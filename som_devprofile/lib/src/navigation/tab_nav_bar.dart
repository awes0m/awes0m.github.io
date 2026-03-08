import 'package:flutter/material.dart';

/// Unified responsive tab navigation bar.
/// On desktop it renders an inline horizontal pill row.
/// On mobile it renders a scrollable bottom-pinned bar.
class TabNavBar extends StatelessWidget {
  const TabNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
    this.isDesktop = true,
  });

  final int selectedIndex;
  final ValueChanged<int> onTabSelected;
  final bool isDesktop;

  static const List<_TabItem> _tabs = [
    _TabItem(
        icon: Icons.person_outline, activeIcon: Icons.person, label: 'About'),
    _TabItem(
        icon: Icons.lightbulb_outline,
        activeIcon: Icons.lightbulb,
        label: 'What I Do'),
    _TabItem(
        icon: Icons.school_outlined,
        activeIcon: Icons.school,
        label: 'Education'),
    _TabItem(
        icon: Icons.work_outline, activeIcon: Icons.work, label: 'Experience'),
    _TabItem(
        icon: Icons.widgets_outlined,
        activeIcon: Icons.widgets,
        label: 'Projects'),
    _TabItem(
        icon: Icons.verified_outlined,
        activeIcon: Icons.verified,
        label: 'Certs'),
    _TabItem(
        icon: Icons.mail_outline, activeIcon: Icons.mail, label: 'Contact'),
  ];

  @override
  Widget build(BuildContext context) {
    return isDesktop ? _buildDesktopNav(context) : _buildMobileNav(context);
  }

  Widget _buildDesktopNav(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(_tabs.length, (i) {
        final tab = _tabs[i];
        final bool selected = i == selectedIndex;
        final Color accent = theme.colorScheme.primary;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              color: selected
                  ? accent.withValues(alpha: 0.12)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () => onTabSelected(i),
                hoverColor: accent.withValues(alpha: 0.08),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        tab.label,
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: selected
                              ? accent
                              : theme.colorScheme.onSurface
                                  .withValues(alpha: 0.75),
                          fontWeight:
                              selected ? FontWeight.w700 : FontWeight.w500,
                          letterSpacing: 0.4,
                        ),
                      ),
                      const SizedBox(height: 4),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        height: 2,
                        width: selected ? 24 : 0,
                        decoration: BoxDecoration(
                          color: accent,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildMobileNav(BuildContext context) {
    final theme = Theme.of(context);
    final Color accent = theme.colorScheme.primary;
    return SafeArea(
      top: false,
      child: Material(
        color: theme.colorScheme.surface,
        elevation: 8,
        child: SizedBox(
          height: 60,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              children: List.generate(_tabs.length, (i) {
                final tab = _tabs[i];
                final bool selected = i == selectedIndex;
                final Color iconColor = selected
                    ? accent
                    : theme.colorScheme.onSurface.withValues(alpha: 0.65);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () => onTabSelected(i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: selected
                            ? accent.withValues(alpha: 0.1)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        border: selected
                            ? Border(top: BorderSide(color: accent, width: 2))
                            : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            selected ? tab.activeIcon : tab.icon,
                            size: 20,
                            color: iconColor,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            tab.label,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight:
                                  selected ? FontWeight.w700 : FontWeight.w500,
                              color: iconColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class _TabItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  const _TabItem(
      {required this.icon, required this.activeIcon, required this.label});
}
