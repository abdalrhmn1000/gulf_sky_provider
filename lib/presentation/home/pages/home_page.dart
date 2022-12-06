import 'package:flutter/material.dart';
import 'package:gulf_sky_provider/presentation/core/utils/generated_assets/assets.gen.dart';
import 'package:gulf_sky_provider/presentation/core/widgets/app_drawer.dart';
import 'package:gulf_sky_provider/presentation/core/widgets/drawer_leading_icon.dart';
import 'package:gulf_sky_provider/presentation/order/widgets/my_order_list_item_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        leading: const DrawerLeadingIcon(),
        centerTitle: true,
        title: Assets.images.logo.image(
          width: 110,
          height: 60,
        ),
      ),
      body:  const MyOrderListItemWidget(),
    );
  }
}
