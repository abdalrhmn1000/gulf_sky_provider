
import 'package:gulf_sky_provider/presentation/core/widgets/custom_dialog_widget.dart';
import 'package:flutter/material.dart';

class CustomDialog {
  Future<dynamic> showCustomDialog(
    mainContext, {
    bool barrierDismissible = false,
    isBuilderChild = true,
    required String title,
    required String message,
    required String buttonName,
    required OnButtonClick onButtonClick,
  }) async {
    return showDialog<dynamic>(
      context: mainContext,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return CustomDialogWidget(
          title: title,
          message: message,
          buttonName: buttonName,
          onButtonClick: onButtonClick,
        );
      },
    );
  }
}
