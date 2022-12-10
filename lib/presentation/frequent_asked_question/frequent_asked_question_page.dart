import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gulf_sky_provider/presentation/core/utils/generated_assets/assets.gen.dart';
import 'package:gulf_sky_provider/presentation/core/widgets/back_leading_icon.dart';
import 'package:gulf_sky_provider/presentation/core/widgets/custom_app_bar.dart';

class FrequentAskedQuestionPage extends StatefulWidget {
  const FrequentAskedQuestionPage({Key? key}) : super(key: key);

  @override
  State<FrequentAskedQuestionPage> createState() =>
      _FrequentAskedQuestionPageState();
}

class _FrequentAskedQuestionPageState extends State<FrequentAskedQuestionPage> {
  final List<String> questions = [
    'general'.tr(),
    'how_does_it_work'.tr(),
    'how_to_start'.tr(),
    'how_to_payment'.tr(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: const BackLeadingIcon(),
        title: Text('frequent_asked_question'.tr()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 17, right: 17, top: 25),
        child: Column(
          children: [
            Assets.images.logo.image(
              width: 224,
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 20),
              child: Text(
                'join_our_community'.tr(),
                style: const TextStyle(fontSize: 18),
              ),
            ),
            ListView.builder(
              itemCount: questions.length,
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemBuilder: (_, index) => Container(
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(8.0)),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    title: Text(questions.elementAt(index)),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
