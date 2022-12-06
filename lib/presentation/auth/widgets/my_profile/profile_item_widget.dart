import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ProfileItemWidget extends StatelessWidget {
  final String title;
  final String description;

  const ProfileItemWidget({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.tr(),
          style: Theme.of(context).textTheme.headline3!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(
            bottom: 15,
            top: 15
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            description,
            style: Theme.of(context).textTheme.headline3!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        )
      ],
    );
  }
}
