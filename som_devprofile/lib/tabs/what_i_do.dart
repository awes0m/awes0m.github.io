import 'package:flutter/material.dart';

import '../src/custom/custom_text.dart';
import '../src/navigation/title_bar.dart';
import '../theme/config.dart';
import '../src/whatIDo/data.dart';
import '../src/whatIDo/progress.dart';

class WhatIdo extends StatelessWidget {
  WhatIdo({Key? key}) : super(key: key);

  final List<List<String>> data = whatIdo();
  static final whatIDoKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: <Widget>[
        TitleBar(
          // Use a fixed dummy width since TitleBar only uses it for relative sizing
          height: height,
          width: MediaQuery.of(context).size.width,
          title: 'WHAT I DO',
        ),
        Padding(
          padding: EdgeInsets.only(bottom: height * 0.05),
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            // Use available width (content card width) not screen width
            final double availableWidth = constraints.maxWidth;
            // Desktop layout when content area is wider than 700px
            final bool isDesktop = availableWidth >= 700;

            if (!isDesktop) {
              // ── MOBILE / NARROW ──────────────────────────────────
              int storage = -1;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 20),
                    child: CustomText(
                        text: '⚡ I have a good proficiency in:',
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 25.0,
                      left: 15.0,
                      right: 15.0,
                    ),
                    // Stack the checklist image above the progress bars
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.asset(
                            currentTheme.currentTheme == ThemeMode.dark
                                ? 'assets/what_i_do/constant/checklist.png'
                                : 'assets/what_i_do/constant/checklist-light.png',
                            scale: 2,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Column(
                          children: List.generate(
                            data[0].length,
                            (int index) => Progress(
                              // Use available width minus padding
                              width: availableWidth - 30,
                              widthSecondContainer:
                                  double.parse(data[0][index].split('--')[1]),
                              title: data[0][index].split('--')[0],
                              sizeProficiencyName: 12,
                              sizePercentage: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 30, 15, 20),
                    child: CustomText(
                        text: data[1].isNotEmpty
                            ? '⚡ Some languages & tools I use:'
                            : '',
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 25, 15, 20),
                    child: Column(
                      children: List.generate(
                        data[1].length % 4 == 0
                            ? data[1].length ~/ 4
                            : data[1].length ~/ 4 + 1,
                        (int i) => Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(
                                (data[1].length - storage - 1) >= 4
                                    ? 4
                                    : data[1].length - storage - 1,
                                (int index) {
                              storage = index + i * 4;
                              return Container(
                                constraints:
                                    BoxConstraints.tight(const Size(50, 50)),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                  'assets/what_i_do/${data[1][index + i * 4]}',
                                ))),
                              );
                            }),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              // ── DESKTOP / WIDE ────────────────────────────────────
              int storage = -1;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 10, 40, 20),
                    child: CustomText(
                        text: '⚡ I have a good proficiency in:',
                        fontSize: 28,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Column(
                            children: List.generate(
                              data[0].length,
                              (int index) => Progress(
                                // Use half available width for progress bars
                                width: availableWidth * 0.55,
                                widthSecondContainer:
                                    double.parse(data[0][index].split('--')[1]),
                                title: data[0][index].split('--')[0],
                                sizeProficiencyName: 18,
                                sizePercentage: 13,
                              ),
                            ),
                          ),
                        ),
                        Image.asset(
                          currentTheme.currentTheme == ThemeMode.dark
                              ? 'assets/what_i_do/constant/checklist.png'
                              : 'assets/what_i_do/constant/checklist-light.png',
                          width: availableWidth * 0.28,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 30, 40, 20),
                    child: CustomText(
                        text: data[1].isNotEmpty
                            ? '⚡ Some languages & tools I use:'
                            : '',
                        fontSize: 28,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 25.0,
                      bottom: 20.0,
                    ),
                    child: Column(
                      children: List.generate(
                        data[1].length % 8 == 0
                            ? data[1].length ~/ 8
                            : data[1].length ~/ 8 + 1,
                        (int i) => Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(
                                (data[1].length - storage - 1) >= 8
                                    ? 8
                                    : data[1].length - storage - 1,
                                (int index) {
                              storage = index + i * 8;
                              return Container(
                                constraints: const BoxConstraints.expand(
                                    width: 72, height: 72),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                  'assets/what_i_do/${data[1][index + i * 4]}',
                                ))),
                              );
                            }),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          }),
        )
      ]),
    );
  }
}
