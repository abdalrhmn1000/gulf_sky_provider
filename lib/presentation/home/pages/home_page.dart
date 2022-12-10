import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gulf_sky_provider/presentation/core/utils/generated_assets/assets.gen.dart';
import 'package:gulf_sky_provider/presentation/order/widgets/my_order_list_item_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Assets.images.logo.image(
                width: 224,
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  'notifications'.tr(),
                  style: const TextStyle(fontSize: 25),
                ),
              ),
              const MyOrderListItemWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
