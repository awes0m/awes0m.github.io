import 'package:flutter/material.dart';

import '../../theme/config.dart';
import '../../theme/design_tokens.dart';

class EducationDesktop extends StatefulWidget {
  const EducationDesktop({
    Key? key,
    required this.instiution,
    required this.location,
    required this.desc,
    required this.grades,
    required this.years,
    required this.image,
  }) : super(key: key);

  final String instiution, location, years, grades, desc, image;

  @override
  State<EducationDesktop> createState() => _EducationDesktopState();
}

class _EducationDesktopState extends State<EducationDesktop> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 1000;

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
            padding: const EdgeInsets.all(DesignTokens.spacingL),
            width: width / 1.15,
            decoration: BoxDecoration(
              gradient: currentTheme.currentTheme == ThemeMode.dark
                  ? DesignTokens.darkCardGradient(isHover: isHover)
                  : DesignTokens.lightCardGradient(isHover: isHover),
              borderRadius:
                  BorderRadius.circular(DesignTokens.cardBorderRadius),
              border: DesignTokens.gradientBorder(isHover: isHover),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo/Image
                Container(
                  width: isMobile ? 60 : 100,
                  height: isMobile ? 60 : 100,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(DesignTokens.smallBorderRadius),
                    boxShadow: DesignTokens.glowShadow(
                      color: DesignTokens.gradientPurple,
                    ),
                    image: DecorationImage(
                      image: AssetImage('assets/education/${widget.image}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: DesignTokens.spacingL),
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.instiution,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: DesignTokens.spacingS),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: Colors.white.withValues(alpha:0.7),
                          ),
                          const SizedBox(width: DesignTokens.spacingXS),
                          Text(
                            widget.location,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withValues(alpha:0.7),
                            ),
                          ),
                        ],
                      ),
                      if (widget.years.isNotEmpty) ...[
                        const SizedBox(height: DesignTokens.spacingS),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: DesignTokens.spacingM,
                            vertical: DesignTokens.spacingS,
                          ),
                          decoration: BoxDecoration(
                            gradient: DesignTokens.primaryGradient(),
                            borderRadius: BorderRadius.circular(
                                DesignTokens.smallBorderRadius),
                          ),
                          child: Text(
                            'Years of study: ${widget.years}',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(height: DesignTokens.spacingM),
                      Text(
                        widget.desc,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white.withValues(alpha:0.9),
                          height: 1.5,
                        ),
                      ),
                      if (widget.grades.isNotEmpty) ...[
                        const SizedBox(height: DesignTokens.spacingM),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 18,
                              color: DesignTokens.gradientBlue,
                            ),
                            const SizedBox(width: DesignTokens.spacingS),
                            Text(
                              'Grades Achieved: ${widget.grades}',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white.withValues(alpha:0.9),
                              ),
                            ),
                          ],
                        ),
                      ],
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
