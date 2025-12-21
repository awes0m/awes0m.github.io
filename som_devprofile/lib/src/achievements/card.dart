import 'package:flutter/material.dart';

import '../html_open_link.dart';
import '../../theme/config.dart';
import '../../theme/design_tokens.dart';

class AchievementsCard extends StatefulWidget {
  const AchievementsCard({
    Key? key,
    required this.desc,
    required this.isMobile,
    required this.link,
    this.imagePath,
    this.showImageDialog = false,
  }) : super(key: key);

  final String desc, link;
  final bool isMobile;
  final String? imagePath;
  final bool showImageDialog;

  @override
  State<AchievementsCard> createState() => _AchievementsCardState();
}

class _AchievementsCardState extends State<AchievementsCard> {
  bool isHover = false;

  void _showCertificateDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.8,
              maxHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(DesignTokens.cardBorderRadius),
              gradient: currentTheme.currentTheme == ThemeMode.dark
                  ? DesignTokens.darkCardGradient()
                  : DesignTokens.lightCardGradient(),
              boxShadow: DesignTokens.glowShadow(),
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(DesignTokens.cardBorderRadius),
                  child: InteractiveViewer(
                    panEnabled: true,
                    boundaryMargin: const EdgeInsets.all(20),
                    minScale: 0.5,
                    maxScale: 3.0,
                    child: widget.imagePath != null
                        ? Image.asset(
                            widget.imagePath!,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                padding: const EdgeInsets.all(DesignTokens.spacingL),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.image_not_supported,
                                      size: 64,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(height: DesignTokens.spacingM),
                                    const Text(
                                      'Certificate image not available',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: DesignTokens.spacingM),
                                    ElevatedButton(
                                      onPressed: () =>
                                          htmlOpenLink(widget.link),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            DesignTokens.gradientPurple,
                                      ),
                                      child: const Text('View Online'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        : const Text('No image available'),
                  ),
                ),
                // Close button
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: DesignTokens.primaryGradient(),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: DesignTokens.glowShadow(),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
                // View original button
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: DesignTokens.primaryGradient(),
                      borderRadius:
                          BorderRadius.circular(DesignTokens.largeBorderRadius),
                      boxShadow: DesignTokens.glowShadow(),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(
                            DesignTokens.largeBorderRadius),
                        onTap: () {
                          Navigator.of(context).pop();
                          htmlOpenLink(widget.link);
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: DesignTokens.spacingL,
                            vertical: DesignTokens.spacingM,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.open_in_new,
                                  color: Colors.white, size: 20),
                              SizedBox(width: 8),
                              Text(
                                'View Original',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

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
          onTap: () => widget.showImageDialog && widget.imagePath != null
              ? _showCertificateDialog(context)
              : htmlOpenLink(widget.link),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(DesignTokens.spacingL),
            width: !widget.isMobile ? width * 0.28 : width,
            decoration: BoxDecoration(
              gradient: currentTheme.currentTheme == ThemeMode.dark
                  ? DesignTokens.darkCardGradient(isHover: isHover)
                  : DesignTokens.lightCardGradient(isHover: isHover),
              borderRadius:
                  BorderRadius.circular(DesignTokens.cardBorderRadius),
              border: DesignTokens.gradientBorder(isHover: isHover),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.emoji_events,
                  color: DesignTokens.gradientBlue,
                  size: 32,
                ),
                const SizedBox(width: DesignTokens.spacingM),
                Expanded(
                  child: Text(
                    widget.desc,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                      height: 1.5,
                    ),
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
