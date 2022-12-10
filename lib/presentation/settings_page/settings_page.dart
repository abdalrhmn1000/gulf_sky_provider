import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gulf_sky_provider/presentation/core/auth/auth_bloc.dart';
import 'package:gulf_sky_provider/presentation/core/routes/router.dart';
import 'package:gulf_sky_provider/presentation/core/utils/custom_dialog.dart';
import 'package:gulf_sky_provider/presentation/core/utils/generated_assets/assets.gen.dart';
import 'package:gulf_sky_provider/presentation/settings_page/widgets/setting_list_tile.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 17, right: 17),
        child: Column(
          children: [
            Assets.images.logo.image(
              width: 224,
              height: 100,
            ),
            const SizedBox(
              height: 20,
            ),
            SettingListTile(
              onTap: () {
                if (context.locale.toString() == 'en') {
                  context.setLocale(const Locale('ar'));
                } else {
                  context.setLocale(const Locale('en'));
                }
              },
              leading: const Icon(Icons.language),
              title: Text('change_language'.tr()),
            ),
            const Divider(),
            SettingListTile(
              onTap: () {
                AutoRouter.of(context).push(const FrequentAskedQuestionPageRoute());
              },
              leading: const Icon(Icons.question_answer),
              title: Text('frequent_asked_question'.tr()),
            ),
            const Divider(),
            SettingListTile(
              onTap: () {
                AutoRouter.of(context).push(const AboutPageRoute());
              },
              leading: const Icon(Icons.info_outline_rounded),
              title: Text('about'.tr()),
            ),
            const Divider(),
            SettingListTile(
              onTap: () {
                CustomDialog().showCustomDialog(
                  context,
                  title: 'logout'.tr(),
                  message: 'are_you_sure_you_want_to_logout'.tr(),
                  buttonName: 'exit'.tr(),
                  onButtonClick: () {
                    BlocProvider.of<AuthBloc>(context).add(AuthLogout());
                  },
                );
              },
              leading: const Icon(Icons.logout),
              title: Text('logout'.tr()),
            ),
          ],
        ),
      )),
    );
  }
}
