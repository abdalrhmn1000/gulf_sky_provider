import 'package:flutter/material.dart';

class CustomTextRickWidget extends StatelessWidget {
  final String title;
  final String description;

  const CustomTextRickWidget({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.57,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: '$title: ',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: description,
            ),
          ],
        ),
        style: const TextStyle(height: 1.5,fontSize: 16),
      ),
    );
  }
}
