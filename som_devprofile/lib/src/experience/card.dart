import 'package:flutter/material.dart';

import '../../theme/config.dart';
import '../../theme/design_tokens.dart';

class ExperienceCard extends StatefulWidget {
  const ExperienceCard({
    Key? key,
    required this.image,
    required this.title,
    required this.desc,
    required this.period,
    required this.role,
    required this.isMobile,
  }) : super(key: key);

  final String image, title, desc, period, role;
  final bool isMobile;

  @override
  State<ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<ExperienceCard> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return AnimatedContainer(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DesignTokens.cardBorderRadius),
        boxShadow: DesignTokens.cardShadow(isHover: isHover),
      ),
      duration: DesignTokens.hoverDuration,
      curve: DesignTokens.defaultCurve,
      padding: EdgeInsets.only(
        top: isHover ? height * 0.005 : height * 0.01,
        bottom: !isHover ? height * 0.005 : height * 0.01,
      ),
      child: Transform.scale(
        scale: isHover ? DesignTokens.hoverScale : DesignTokens.normalScale,
        child: InkWell(
          onHover: (bool value) {
            setState(() {
              isHover = value;
            });
          },
          onTap: () {},
          child: Container(
            alignment: Alignment.topCenter,
            width: !widget.isMobile ? width * 0.28 : width,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(DesignTokens.cardBorderRadius),
              border: DesignTokens.gradientBorder(isHover: isHover),
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Column(
              children: [
                // Image section with rounded top
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(DesignTokens.cardBorderRadius),
                    topRight: Radius.circular(DesignTokens.cardBorderRadius),
                  ),
                  child: Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: DesignTokens.primaryGradient(isHover: isHover),
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/experience/${widget.image}',
                        height: 80,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                // Content section
                Container(
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.all(DesignTokens.spacingL),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: currentTheme.currentTheme == ThemeMode.dark
                        ? DesignTokens.darkCardGradient(isHover: isHover)
                        : DesignTokens.lightCardGradient(isHover: isHover),
                    borderRadius: const BorderRadius.only(
                      bottomLeft:
                          Radius.circular(DesignTokens.cardBorderRadius),
                      bottomRight:
                          Radius.circular(DesignTokens.cardBorderRadius),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: DesignTokens.spacingS),
                      Text(
                        widget.role,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withValues(alpha:0.9),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: DesignTokens.spacingM),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: DesignTokens.spacingM,
                          vertical: DesignTokens.spacingS,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha:0.1),
                          borderRadius: BorderRadius.circular(
                              DesignTokens.smallBorderRadius),
                        ),
                        child: Text(
                          widget.period,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withValues(alpha:0.8),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: DesignTokens.spacingM),
                      Text(
                        widget.desc,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white.withValues(alpha:0.9),
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
