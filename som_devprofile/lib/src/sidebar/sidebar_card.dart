import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../home/data.dart';
import '../home/resume.dart';
import '../html_open_link.dart';
import '../../theme/theme_button.dart';

/// Sticky sidebar card showing identity/profile info.
/// Renders full-width on mobile with a collapsible contacts section.
class SidebarCard extends StatefulWidget {
  const SidebarCard({super.key, required this.isMobile});
  final bool isMobile;

  @override
  State<SidebarCard> createState() => _SidebarCardState();
}

class _SidebarCardState extends State<SidebarCard> {
  bool _showContacts = false;
  // Designation cycling
  int _designationIndex = 0;

  @override
  void initState() {
    super.initState();
    _cycleDesignation();
  }

  void _cycleDesignation() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        final list = designation();
        if (list.isNotEmpty) {
          setState(() {
            _designationIndex = (_designationIndex + 1) % list.length;
          });
        }
        _cycleDesignation();
      }
    });
  }

  String get _currentDesignation {
    final list = designation();
    if (list.isEmpty) return '';
    return list[_designationIndex % list.length];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Container(
      width: widget.isMobile ? double.infinity : 270,
      margin: widget.isMobile
          ? const EdgeInsets.fromLTRB(12, 12, 12, 0)
          : const EdgeInsets.fromLTRB(16, 16, 8, 16),
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
      child: widget.isMobile
          ? _buildMobileLayout(theme, size)
          : _buildDesktopLayout(theme, size),
    );
  }

  // ──────────────────────────────── DESKTOP ────────────────────────────────

  Widget _buildDesktopLayout(ThemeData theme, Size size) {
    final String gotName = name();
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          // Avatar
          _buildAvatar(72),
          const SizedBox(height: 14),
          // Name — constrained to sidebar width
          Text(
            gotName,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: GoogleFonts.novaMono(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onSurface,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 8),
          // Designation — simple animated text chip (no unconstrained Row)
          _buildDesignationChip(theme),
          const Divider(height: 24, thickness: 0.5),
          // Contact info rows
          _buildContactRows(theme),
          const Divider(height: 20, thickness: 0.5),
          // Social media icons
          _buildSocialIcons(),
          const SizedBox(height: 14),
          // Resume button — FittedBox scales it to sidebar width
          const FittedBox(
            fit: BoxFit.scaleDown,
            child: Resume(width: 0),
          ),
          const SizedBox(height: 16),
          // Theme toggle
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Theme',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
              const SizedBox(width: 8),
              const ThemeButton(),
            ],
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  // ──────────────────────────────── MOBILE ────────────────────────────────

  Widget _buildMobileLayout(ThemeData theme, Size size) {
    final String gotName = name();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Always-visible header row
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
          child: Row(
            children: [
              _buildAvatar(40),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      gotName,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.novaMono(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    // Simple designation text — no unconstrained Row
                    Text(
                      _currentDesignation,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              // Theme toggle
              const ThemeButton(),
              // Expand contacts toggle
              GestureDetector(
                onTap: () => setState(() => _showContacts = !_showContacts),
                child: AnimatedRotation(
                  turns: _showContacts ? 0.5 : 0,
                  duration: const Duration(milliseconds: 250),
                  child: Icon(
                    Icons.expand_more_rounded,
                    color: theme.colorScheme.primary,
                    size: 26,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Collapsible contacts section
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(thickness: 0.5),
                _buildContactRows(theme),
                const SizedBox(height: 8),
                _buildSocialIcons(),
                const SizedBox(height: 8),
                const FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Resume(width: 0),
                ),
              ],
            ),
          ),
          crossFadeState: _showContacts
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
        ),
      ],
    );
  }

  // ──────────────────────────────── SHARED ────────────────────────────────

  Widget _buildDesignationChip(ThemeData theme) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      child: Container(
        key: ValueKey<String>(_currentDesignation),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          _currentDesignation,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w600,
            fontSize: 12,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar(double radius) {
    return ClipOval(
      child: Image.asset(
        'assets/contact_me/personal.png',
        width: radius * 2,
        height: radius * 2,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => CircleAvatar(
          radius: radius,
          child: Icon(Icons.person, size: radius * 0.8),
        ),
      ),
    );
  }

  Widget _buildContactRows(ThemeData theme) {
    final List<Map<String, dynamic>> contacts = [
      {
        'icon': Icons.email_outlined,
        'label': 'EMAIL',
        'value': _getContact('email'),
      },
      {
        'icon': Icons.location_on_outlined,
        'label': 'LOCATION',
        'value': _getContact('location'),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: contacts.map((c) {
        final String val = c['value'] as String;
        if (val.isEmpty) return const SizedBox.shrink();
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Icon(c['icon'] as IconData,
                    size: 16,
                    color: theme.colorScheme.primary.withValues(alpha: 0.8)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      c['label'] as String,
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontSize: 9,
                        letterSpacing: 1.2,
                        color:
                            theme.colorScheme.onSurface.withValues(alpha: 0.5),
                      ),
                    ),
                    Text(
                      val,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.w500,
                        fontSize: 11,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSocialIcons() {
    final data = socialMedia();
    const supportedPlatforms = [
      'email',
      'facebook',
      'github',
      'instagram',
      'linkedin',
      'medium',
      'stackoverflow',
      'twitter',
      'leetcode'
    ];
    return Wrap(
      spacing: 2,
      runSpacing: 2,
      children: data.map((item) {
        final String link = item[0];
        final String platform = item.length > 1 ? item[1] : '';
        final String imagePath = supportedPlatforms.contains(platform)
            ? 'assets/home/constant/$platform.png'
            : 'assets/home/constant/link.png';
        return IconButton(
          iconSize: 20,
          padding: const EdgeInsets.all(6),
          constraints: const BoxConstraints(),
          hoverColor: Colors.transparent,
          icon: Image.asset(imagePath, width: 20, height: 20),
          onPressed: () => htmlOpenLink(link),
          tooltip: platform.isEmpty ? link : platform,
        );
      }).toList(),
    );
  }

  String _getContact(String key) {
    try {
      final data = socialMedia();
      for (final item in data) {
        if (item.length > 1 && item[1] == key) return item[0];
      }
    } catch (_) {}
    return '';
  }
}
