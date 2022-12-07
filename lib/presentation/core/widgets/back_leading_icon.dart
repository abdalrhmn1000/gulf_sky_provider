import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BackLeadingIcon extends StatelessWidget {
  final bool? isLightColor;

  const BackLeadingIcon({Key? key, this.isLightColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.only(
          left: context.locale.toString() == 'en' ? 6.0 : 0,
          right: context.locale.toString() == 'en' ? 0 : 12),
      minWidth: 40,
      height: 40,
      //  color: Theme.of(context).cardTheme.color,
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Icon(
        Icons.arrow_back_ios,
        color: (isLightColor ?? false)
            ? Theme.of(context).colorScheme.onSecondary
            : Theme.of(context).primaryColor,
        size: 30.0,
      ),
    );
  }
}
