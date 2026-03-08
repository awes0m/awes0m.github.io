import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../home/data.dart';

/// The "About" tab content — shows the bio/about text only.
/// (Profile photo, name, designation etc. have moved to the SidebarCard.)
class AboutTab extends StatelessWidget {
  const AboutTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final String gotAbout = about();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About Me',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w800,
              color: theme.colorScheme.onSurface,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            width: 40,
            height: 3,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          if (gotAbout.isNotEmpty)
            Text(
              gotAbout,
              style: GoogleFonts.dmMono(
                fontSize: 15,
                height: 1.75,
                letterSpacing: 1.5,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.85),
              ),
            )
          else
            const Text('No bio available.'),
        ],
      ),
    );
  }
}
