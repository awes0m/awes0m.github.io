import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../custom/custom_text.dart';
import '../html_open_link.dart';
import '../../theme/config.dart';
import 'data.dart';

class ProjectsCard extends StatefulWidget {
  const ProjectsCard({
    Key? key,
    required this.title,
    required this.techStack,
    required this.desc,
    required this.link,
    this.readmeLink,
    required this.isMobile,
  }) : super(key: key);

  final String title, techStack, desc, link;
  final String? readmeLink;
  final bool isMobile;

  @override
  State<ProjectsCard> createState() => _ProjectsCardState();
}

class _ProjectsCardState extends State<ProjectsCard> {
  bool isHover = false;

  void _showProjectDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.85,
              maxHeight: MediaQuery.of(context).size.height * 0.85,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: currentTheme.currentTheme == ThemeMode.dark
                    ? [
                        const Color(0xFF1a1a2e),
                        const Color(0xFF16213e),
                      ]
                    : [
                        const Color(0xFFf0f0f0),
                        const Color(0xFFe0e0e0),
                      ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha:0.3),
                  blurRadius: 30,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Stack(
              children: [
                // Content
                Column(
                  children: [
                    // Header
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            const Color(0xFF6a11cb).withValues(alpha:0.8),
                            const Color(0xFF2575fc).withValues(alpha:0.8),
                          ],
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.title.isEmpty
                                      ? 'Project Details'
                                      : widget.title,
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                if (widget.techStack.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Text(
                                      widget.techStack,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white.withValues(alpha:0.9),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // README Content
                    Expanded(
                      child: widget.readmeLink != null
                          ? FutureBuilder<String>(
                              future: fetchReadme(widget.readmeLink!),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            currentTheme.currentTheme ==
                                                    ThemeMode.dark
                                                ? const Color(0xFF6a11cb)
                                                : const Color(0xFF2575fc),
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          'Loading README...',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: currentTheme.currentTheme ==
                                                    ThemeMode.dark
                                                ? Colors.white70
                                                : Colors.black87,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  return Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(24),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.error_outline,
                                            size: 64,
                                            color: Colors.red.withValues(alpha:0.7),
                                          ),
                                          const SizedBox(height: 16),
                                          Text(
                                            'Failed to load README',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  currentTheme.currentTheme ==
                                                          ThemeMode.dark
                                                      ? Colors.white
                                                      : Colors.black87,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            snapshot.error.toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color:
                                                  currentTheme.currentTheme ==
                                                          ThemeMode.dark
                                                      ? Colors.white70
                                                      : Colors.black54,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                } else if (snapshot.hasData) {
                                  return Container(
                                    padding: const EdgeInsets.all(24),
                                    child: Markdown(
                                      data: snapshot.data!,
                                      selectable: true,
                                      styleSheet: MarkdownStyleSheet(
                                        // Paragraph styling
                                        p: TextStyle(
                                          fontSize: 16,
                                          height: 1.6,
                                          color: currentTheme.currentTheme ==
                                                  ThemeMode.dark
                                              ? Colors.white.withValues(alpha:0.9)
                                              : Colors.black87,
                                        ),
                                        // Heading styles
                                        h1: TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          height: 1.3,
                                          color: currentTheme.currentTheme ==
                                                  ThemeMode.dark
                                              ? Colors.white
                                              : Colors.black87,
                                        ),
                                        h2: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                          height: 1.3,
                                          color: currentTheme.currentTheme ==
                                                  ThemeMode.dark
                                              ? Colors.white
                                              : Colors.black87,
                                        ),
                                        h3: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          height: 1.3,
                                          color: currentTheme.currentTheme ==
                                                  ThemeMode.dark
                                              ? Colors.white
                                              : Colors.black87,
                                        ),
                                        h4: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          height: 1.3,
                                          color: currentTheme.currentTheme ==
                                                  ThemeMode.dark
                                              ? Colors.white.withValues(alpha:0.95)
                                              : Colors.black87,
                                        ),
                                        h5: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          height: 1.3,
                                          color: currentTheme.currentTheme ==
                                                  ThemeMode.dark
                                              ? Colors.white.withValues(alpha:0.95)
                                              : Colors.black87,
                                        ),
                                        h6: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          height: 1.3,
                                          color: currentTheme.currentTheme ==
                                                  ThemeMode.dark
                                              ? Colors.white.withValues(alpha:0.9)
                                              : Colors.black87,
                                        ),
                                        // Inline code styling
                                        code: TextStyle(
                                          fontFamily: 'monospace',
                                          fontSize: 14,
                                          backgroundColor:
                                              currentTheme.currentTheme ==
                                                      ThemeMode.dark
                                                  ? Colors.black38
                                                  : Colors.grey[200],
                                          color: currentTheme.currentTheme ==
                                                  ThemeMode.dark
                                              ? const Color(0xFF6a11cb)
                                              : const Color(0xFF2575fc),
                                        ),
                                        // Code block styling
                                        codeblockDecoration: BoxDecoration(
                                          color: currentTheme.currentTheme ==
                                                  ThemeMode.dark
                                              ? Colors.black38
                                              : Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                            color: currentTheme.currentTheme ==
                                                    ThemeMode.dark
                                                ? Colors.white12
                                                : Colors.grey[300]!,
                                            width: 1,
                                          ),
                                        ),
                                        codeblockPadding:
                                            const EdgeInsets.all(16),
                                        // Blockquote styling
                                        blockquote: TextStyle(
                                          color: currentTheme.currentTheme ==
                                                  ThemeMode.dark
                                              ? Colors.white70
                                              : Colors.black54,
                                          fontStyle: FontStyle.italic,
                                          fontSize: 16,
                                          height: 1.6,
                                        ),
                                        blockquoteDecoration: BoxDecoration(
                                          color: currentTheme.currentTheme ==
                                                  ThemeMode.dark
                                              ? Colors.white.withValues(alpha:0.05)
                                              : Colors.grey[100],
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          border: const Border(
                                            left: BorderSide(
                                              color: Color(0xFF6a11cb),
                                              width: 4,
                                            ),
                                          ),
                                        ),
                                        blockquotePadding:
                                            const EdgeInsets.all(12),
                                        // Link styling
                                        a: TextStyle(
                                          color: currentTheme.currentTheme ==
                                                  ThemeMode.dark
                                              ? const Color(0xFF6a11cb)
                                              : const Color(0xFF2575fc),
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        // List styling
                                        listBullet: TextStyle(
                                          fontSize: 16,
                                          color: currentTheme.currentTheme ==
                                                  ThemeMode.dark
                                              ? const Color(0xFF6a11cb)
                                              : const Color(0xFF2575fc),
                                        ),
                                        listIndent: 24,
                                        // Table styling
                                        tableBorder: TableBorder.all(
                                          color: currentTheme.currentTheme ==
                                                  ThemeMode.dark
                                              ? Colors.white24
                                              : Colors.grey[300]!,
                                          width: 1,
                                        ),
                                        tableHead: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                        tableBody: TextStyle(
                                          fontSize: 15,
                                          color: currentTheme.currentTheme ==
                                                  ThemeMode.dark
                                              ? Colors.white.withValues(alpha:0.9)
                                              : Colors.black87,
                                        ),
                                        tableHeadAlign: TextAlign.left,
                                        tableCellsPadding:
                                            const EdgeInsets.all(12),
                                        tableColumnWidth:
                                            const FlexColumnWidth(),
                                        // Horizontal rule
                                        horizontalRuleDecoration: BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                              color:
                                                  currentTheme.currentTheme ==
                                                          ThemeMode.dark
                                                      ? Colors.white24
                                                      : Colors.grey[300]!,
                                              width: 2,
                                            ),
                                          ),
                                        ),
                                        // Strong and emphasis
                                        strong: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: currentTheme.currentTheme ==
                                                  ThemeMode.dark
                                              ? Colors.white
                                              : Colors.black87,
                                        ),
                                        em: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: currentTheme.currentTheme ==
                                                  ThemeMode.dark
                                              ? Colors.white.withValues(alpha:0.9)
                                              : Colors.black87,
                                        ),
                                        // Text alignment
                                        textAlign: WrapAlignment.start,
                                      ),
                                    ),
                                  );
                                }
                                return const Center(
                                  child: Text('No README available'),
                                );
                              },
                            )
                          : Center(
                              child: Padding(
                                padding: const EdgeInsets.all(24),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.description_outlined,
                                      size: 64,
                                      color: currentTheme.currentTheme ==
                                              ThemeMode.dark
                                          ? Colors.white38
                                          : Colors.black38,
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'No README available for this project',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: currentTheme.currentTheme ==
                                                ThemeMode.dark
                                            ? Colors.white70
                                            : Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
                // Close button
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha:0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
                // View on GitHub button
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF6a11cb).withValues(alpha:0.9),
                          const Color(0xFF2575fc).withValues(alpha:0.9),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6a11cb).withValues(alpha:0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(25),
                        onTap: () {
                          Navigator.of(context).pop();
                          htmlOpenLink(widget.link);
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.open_in_new,
                                  color: Colors.white, size: 20),
                              SizedBox(width: 8),
                              Text(
                                'View on GitHub',
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
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: isHover
                ? const Color(0xFF6a11cb).withValues(alpha:0.3)
                : Colors.black45,
            blurRadius: isHover ? 20.0 : 10.0,
            offset: Offset(isHover ? 0 : 8, isHover ? 8 : 12),
          )
        ],
      ),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      padding: EdgeInsets.only(
        top: isHover ? height * 0.005 : height * 0.01,
        bottom: !isHover ? height * 0.005 : height * 0.01,
      ),
      child: Transform.scale(
        scale: isHover ? 1.02 : 1.0,
        child: InkWell(
          onHover: (bool value) {
            setState(() {
              isHover = value;
            });
          },
          onTap: () {
            if (widget.readmeLink != null) {
              _showProjectDetailsDialog(context);
            } else {
              htmlOpenLink(widget.link);
            }
          },
          child: Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(
              top: height * 0.02,
              left: width * 0.015,
              right: width * 0.015,
              bottom: height * 0.02,
            ),
            width: !widget.isMobile ? width * 0.28 : width,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: isHover
                      ? const Color(0xFF6a11cb).withValues(alpha:0.2)
                      : Colors.black45,
                  blurRadius: 10.0,
                  offset: const Offset(8, 12),
                )
              ],
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: currentTheme.currentTheme == ThemeMode.dark
                    ? isHover
                        ? [
                            const Color(0xFF1a1a2e),
                            const Color(0xFF16213e),
                            const Color(0xFF0f3460),
                          ]
                        : [
                            const Color(0xFF1a1a2e),
                            const Color(0xFF16213e),
                          ]
                    : isHover
                        ? [
                            const Color(0xFFe8eaf6),
                            const Color(0xFFc5cae9),
                            const Color(0xFF9fa8da),
                          ]
                        : [
                            Theme.of(context).colorScheme.primary,
                            Theme.of(context).colorScheme.primary,
                          ],
              ),
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                color: isHover
                    ? const Color(0xFF6a11cb).withValues(alpha:0.5)
                    : Colors.transparent,
                width: 2,
              ),
            ),
            child: (widget.title == '' && widget.link != '')
                ? FutureBuilder(
                    future: github(widget.link),
                    builder: (BuildContext context,
                        AsyncSnapshot<Object?> snapshot) {
                      if (snapshot.hasData) {
                        final List<String> data = snapshot.data as List<String>;
                        return Column(
                          children: [
                            Center(
                              child: Column(
                                children: <Widget>[
                                  FittedBox(
                                    fit: BoxFit.cover,
                                    child: CustomText(
                                      text: data[0],
                                      fontSize: 25,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5.0, bottom: 16.0),
                                    child: FittedBox(
                                      fit: BoxFit.cover,
                                      child: CustomText(
                                        text: data[1],
                                        fontSize: 14,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ),
                                  CustomText(
                                    text: data[2],
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Image.asset(
                                    'assets/projects/constant/stars.png',
                                    scale: 2),
                                Padding(
                                  padding: const EdgeInsets.only(right: 24.0),
                                  child: CustomText(
                                    text: ' ${data[3]}',
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                                Image.asset(
                                    'assets/projects/constant/forks.png',
                                    scale: 2),
                                CustomText(
                                  text: ' ${data[4]}',
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ],
                        );
                      }
                      return const Center();
                    })
                : Column(
                    children: [
                      Center(
                        child: Column(
                          children: <Widget>[
                            FittedBox(
                              fit: BoxFit.cover,
                              child: Text(
                                widget.title,
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 5.0, bottom: 16.0),
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: Text(
                                  widget.techStack,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white.withValues(alpha:0.8),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
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
                      FutureBuilder(
                        future: starsAndForks(widget.link),
                        builder: (BuildContext context,
                            AsyncSnapshot<Object?> snapshot) {
                          if (snapshot.hasData) {
                            final List<String> data =
                                snapshot.data as List<String>;
                            if (data[1] == 'null' && data[0] == 'null') {
                              return const Center();
                            }
                            return Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, left: 5.0),
                              child: Row(
                                children: [
                                  Image.asset(
                                      'assets/projects/constant/stars.png',
                                      scale: 2),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 24.0),
                                    child: CustomText(
                                      text: ' ${data[0]}',
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Image.asset(
                                      'assets/projects/constant/forks.png',
                                      scale: 2),
                                  CustomText(
                                    text: ' ${data[1]}',
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            );
                          }
                          return const Center();
                        },
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
