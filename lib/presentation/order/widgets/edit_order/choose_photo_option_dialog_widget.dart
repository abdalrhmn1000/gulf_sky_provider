import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';

class ChoosePhotoOptionDialogWidget extends StatefulWidget {
  final Function(File) image;

  const ChoosePhotoOptionDialogWidget({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  State<ChoosePhotoOptionDialogWidget> createState() => _ChoosePhotoOptionDialogWidgetState();
}

class _ChoosePhotoOptionDialogWidgetState extends State<ChoosePhotoOptionDialogWidget> {
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 10),
      contentTextStyle: TextStyle(
        color: Theme.of(context).textTheme.headline1!.color!,
        fontWeight: FontWeight.normal,
        fontSize: 16,
      ),
      titleTextStyle: TextStyle(
        color: Theme.of(context).textTheme.headline1!.color!,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      title: Center(
        child: Text(
          'take_a_photo_from'.tr(),
        ),
      ),
      content: SizedBox(
        height: 160,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                height: 24,
              ),
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () async{
                  final image =
                      await _picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                  widget.image(File(image.path));
                  AutoRouter.of(context).pop();
                  }

                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).indicatorColor.withOpacity(0.1),
                    border: Border.all(
                        color: Theme.of(context).textTheme.headline6!.color!),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'gallery',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ).tr(),
                      Icon(
                        Icons.photo,
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () async{
                  final image =
                  await _picker.pickImage(source: ImageSource.camera);
                  if (image != null) {
                   widget.image(File(image.path));
                   AutoRouter.of(context).pop();
                  }

                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).indicatorColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        color: Theme.of(context).textTheme.headline6!.color!),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'camera',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ).tr(),
                      Icon(
                        Icons.camera,
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    backgroundColor: Colors.white,
                    fixedSize: const Size.fromHeight(39),
                    padding: const EdgeInsets.all(8)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'close'.tr(),
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
