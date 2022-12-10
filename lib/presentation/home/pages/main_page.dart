import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gulf_sky_provider/presentation/core/routes/router.dart';
import 'package:gulf_sky_provider/presentation/core/utils/generated_assets/assets.gen.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (currentIndex == 0) {
          return true;
        } else {
          context.router.navigate(const HomePageRoute());
          return false;
        }
      },
      child: AutoTabsScaffold(
        extendBody: false,
        routes: const [HomePageRoute(), SettingsPageRoute()],
        bottomNavigationBuilder: (_, tabsRouter) {
          return SizedBox(
            height: 74,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: BottomNavigationBar(
                selectedFontSize: 13,
                unselectedFontSize: 13,
                backgroundColor: Colors.white,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                selectedItemColor: Theme.of(context).colorScheme.primary,
                unselectedItemColor: const Color(0xFFAAAAAA),
                elevation: 10,
                type: BottomNavigationBarType.fixed,
                currentIndex: currentIndex = tabsRouter.activeIndex,
                onTap: tabsRouter.setActiveIndex,
                items: [
                  BottomNavigationBarItem(
                    icon:  SizedBox(
                        width: 30, height: 30, child: Image.asset(Assets.icons.home.path)),
                    label: 'home'.tr(),
                    activeIcon: SizedBox(
                        width: 30, height: 30, child: Image.asset(Assets.icons.home.path)),
                  ),
                  BottomNavigationBarItem(
                    icon:  SizedBox(
                        width: 30, height: 30, child: Image.asset(Assets.icons.menu.path)),
                    label: 'settings'.tr(),
                    activeIcon: SizedBox(
                        width: 30, height: 30, child:  Image.asset(Assets.icons.menu.path)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
