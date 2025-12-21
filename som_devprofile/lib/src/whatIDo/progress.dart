import 'package:flutter/material.dart';

import '../custom/custom_text.dart';
import '../../theme/design_tokens.dart';

class Progress extends StatefulWidget {
  const Progress({
    Key? key,
    required this.width,
    required this.widthSecondContainer,
    required this.title,
    required this.sizeProficiencyName,
    required this.sizePercentage,
  }) : super(key: key);

  @override
  State<Progress> createState() => _ProgressState();

  final double width, widthSecondContainer, sizeProficiencyName, sizePercentage;
  final String title;
}

class _ProgressState extends State<Progress>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      upperBound: widget.widthSecondContainer / 100,
    );
    animationController.addListener(() {
      setState(() {});
    });
    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double percentage = animationController.value * 100;

    return FittedBox(
      fit: BoxFit.cover,
      child: Padding(
        padding: const EdgeInsets.only(top: DesignTokens.spacingM),
        child: Column(
          children: [
            SizedBox(
              width: widget.width / 1.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: widget.title,
                    fontSize: widget.sizeProficiencyName,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DesignTokens.spacingM,
                      vertical: DesignTokens.spacingXS,
                    ),
                    decoration: BoxDecoration(
                      gradient: DesignTokens.primaryGradient(),
                      borderRadius:
                          BorderRadius.circular(DesignTokens.smallBorderRadius),
                      boxShadow: DesignTokens.glowShadow(),
                    ),
                    child: Text(
                      '${percentage.toStringAsFixed(0)}%',
                      style: TextStyle(
                        fontSize: widget.sizePercentage,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: DesignTokens.spacingS),
            SizedBox(
              width: widget.width / 1.2,
              height: 24,
              child: Stack(
                children: [
                  // Background container
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha:0.1),
                      borderRadius:
                          BorderRadius.circular(DesignTokens.smallBorderRadius),
                      border: Border.all(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withValues(alpha:0.2),
                        width: 1,
                      ),
                    ),
                  ),
                  // Animated progress bar
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(DesignTokens.smallBorderRadius),
                    child: AnimatedContainer(
                      duration: DesignTokens.slowDuration,
                      width: (widget.width / 1.2) * animationController.value,
                      decoration: BoxDecoration(
                        gradient: DesignTokens.primaryGradient(),
                        boxShadow: DesignTokens.glowShadow(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
