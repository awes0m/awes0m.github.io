import 'package:flutter/material.dart';

import '../html_open_link.dart';
import 'data.dart';

class SocialMediaBar extends StatelessWidget {
  SocialMediaBar({Key? key, required this.height}) : super(key: key);
  final List<List<String>> data = socialMedia();
  final double height;

  @override
  Widget build(BuildContext context) {
    final List<String> currentSupportedSocialMedia = [
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
    return Padding(
        padding: EdgeInsets.only(top: height * 0.01),
        child: FittedBox(
          fit: BoxFit.cover,
          child: Column(children: [
            Row(
              children: List.generate(data.length, (int i) {
                return IconButton(
                    iconSize: 20.0,
                    hoverColor: Colors.transparent,
                    icon: (data[i][1] != '' &&
                            currentSupportedSocialMedia.contains(data[i][1]))
                        ? SocialMediaButton(
                            image: 'assets/home/constant/${data[i][1]}.png',
                            link: data[i][0],
                            height: height)
                        : SocialMediaButton(
                            image: 'assets/home/constant/link.png',
                            link: data[i][0],
                            height: height,
                          ),
                    onPressed: () {
                      htmlOpenLink(data[i][0]);
                    });
              }),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                // make the button larger horizontally

                style: ElevatedButton.styleFrom(
                  // Set the width and height
                  backgroundColor: Colors.orangeAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: const BorderSide(color: Colors.yellow),
                  ),
                  //add animation to button
                  elevation: 5,
                  shadowColor: Colors.black54,
                  animationDuration: const Duration(milliseconds: 300),
                ),
                onPressed: () =>
                    {htmlOpenLink('https://awes0m.github.io/fortpolio/')},
                child: const Text(
                  '                       Visit- My Works Gallery!                       ',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontFeatures: [FontFeature.enable('smcp')],
                      fontStyle: FontStyle.italic),
                )),
          ]),
        ));
  }
}

class SocialMediaButton extends StatefulWidget {
  const SocialMediaButton(
      {Key? key, required this.image, required this.height, required this.link})
      : super(key: key);
  @override
  State<SocialMediaButton> createState() => _SocialMediaButton();

  final String image, link;
  final double height;
}

class _SocialMediaButton extends State<SocialMediaButton> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.only(
          top: isHover ? widget.height * 0.005 : widget.height * 0.01,
          bottom: !isHover ? widget.height * 0.005 : widget.height * 0.01),
      child: InkWell(
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          htmlOpenLink(widget.link);
        },
        onHover: (bool val) {
          setState(() {
            isHover = val;
          });
        },
        child: Image.asset(
          widget.image,
        ),
      ),
    );
  }
}
