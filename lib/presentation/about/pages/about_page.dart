import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gulf_sky_provider/presentation/core/utils/generated_assets/assets.gen.dart';
import 'package:gulf_sky_provider/presentation/core/widgets/back_leading_icon.dart';
import 'package:gulf_sky_provider/presentation/core/widgets/custom_app_bar.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: const BackLeadingIcon(),
        title: Text('about'.tr()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 17, right: 17, top: 25),
        child: Column(
          children: [
            Assets.images.logo.image(
              width: 224,
              height: 100,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'about_description'.tr(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
