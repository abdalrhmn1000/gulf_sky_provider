import 'package:auto_route/annotations.dart';
import 'package:gulf_sky_provider/presentation/about/pages/about_page.dart';

import 'package:gulf_sky_provider/presentation/auth/pages/my_profile_page.dart';

import 'package:gulf_sky_provider/presentation/auth/pages/login_page.dart';
import 'package:gulf_sky_provider/presentation/auth/pages/sign_up_page.dart';

import 'package:gulf_sky_provider/presentation/core/pages/splash_page.dart';
import 'package:gulf_sky_provider/presentation/home/pages/home_page.dart';
import 'package:gulf_sky_provider/presentation/order/pages/edit_order_page.dart';
export 'router.gr.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: SplashPage, initial: true),
    AutoRoute(page: LoginPage),
    AutoRoute(page: SignUpPage),
    AutoRoute(page: MyProfilePage),
    AutoRoute(page: HomePage),
    AutoRoute(page: EditOrderPage),
    AutoRoute(page: AboutPage),
  ],
)
class $AppRouter {}
