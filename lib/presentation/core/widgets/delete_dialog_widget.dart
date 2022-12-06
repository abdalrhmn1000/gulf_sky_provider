import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DeleteDialogWidget extends StatelessWidget {
  final String title;
  final String message;
  final Function onDelete;

  const DeleteDialogWidget({
    Key? key,
    required this.title,
    required this.message,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(),
      child: AlertDialog(
          scrollable: true,
          insetPadding: const EdgeInsets.only(left: 22, right: 22),
          contentPadding: const EdgeInsets.all(0),
          shape: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide.none),
          content: Container(
            padding: const EdgeInsets.all(20.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.transparent, width: 0.5),
              borderRadius: BorderRadius.circular(9),
              color: Theme.of(context).cardColor,
            ),
            child: Column(
              children: [
                Center(
                  child: Text(
                    '${'delete'.tr()} $title',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  '${'delete_message'.tr()} $message ?',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                const SizedBox(
                  height: 36,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                            fixedSize: const Size.fromHeight(39),
                            padding: const EdgeInsets.all(8)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'close'.tr(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).errorColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                            fixedSize: const Size.fromHeight(39),
                            padding: const EdgeInsets.all(8)),
                        onPressed: () {
                          Navigator.of(context).pop();
                          onDelete();
                        },
                        child: Text(
                          'delete'.tr(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
