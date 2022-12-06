import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class OnBoardingSlide extends StatelessWidget {
  final String image;
  final String headText;

  final double absoluteFooterHeight = 200.0;

  const OnBoardingSlide({
    Key? key,
    required this.image,
    required this.headText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              image,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            )),
        Padding(
          padding: const EdgeInsets.only(
            top: 16.0,
            left: 20,
            right: 20,
          ),
          child: AutoSizeText(
            headText,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
            minFontSize: 18,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
