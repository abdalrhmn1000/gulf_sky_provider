// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i11;
import 'package:flutter/material.dart' as _i12;

import '../../../domain/order/entities/order.dart' as _i13;
import '../../../domain/order/entities/order_details.dart' as _i14;
import '../../about/pages/about_page.dart' as _i6;
import '../../auth/pages/login_page.dart' as _i2;
import '../../auth/pages/my_profile_page.dart' as _i4;
import '../../auth/pages/sign_up_page.dart' as _i3;
import '../../frequent_asked_question/frequent_asked_question_page.dart' as _i7;
import '../../home/pages/home_page.dart' as _i9;
import '../../home/pages/main_page.dart' as _i8;
import '../../order/pages/edit_order_page.dart' as _i5;
import '../../settings_page/settings_page.dart' as _i10;
import '../pages/splash_page.dart' as _i1;

class AppRouter extends _i11.RootStackRouter {
  AppRouter([_i12.GlobalKey<_i12.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i11.PageFactory> pagesMap = {
    SplashPageRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SplashPage(),
      );
    },
    LoginPageRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.LoginPage(),
      );
    },
    SignUpPageRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.SignUpPage(),
      );
    },
    MyProfilePageRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.MyProfilePage(),
      );
    },
    EditOrderPageRoute.name: (routeData) {
      final args = routeData.argsAs<EditOrderPageRouteArgs>();
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.EditOrderPage(
          key: args.key,
          order: args.order,
          orderDetails: args.orderDetails,
        ),
      );
    },
    AboutPageRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.AboutPage(),
      );
    },
    FrequentAskedQuestionPageRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.FrequentAskedQuestionPage(),
      );
    },
    MainPageRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i8.MainPage(),
      );
    },
    HomePageRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i9.HomePage(),
      );
    },
    SettingsPageRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i10.SettingsPage(),
      );
    },
  };

  @override
  List<_i11.RouteConfig> get routes => [
        _i11.RouteConfig(
          SplashPageRoute.name,
          path: '/',
        ),
        _i11.RouteConfig(
          LoginPageRoute.name,
          path: '/login-page',
        ),
        _i11.RouteConfig(
          SignUpPageRoute.name,
          path: '/sign-up-page',
        ),
        _i11.RouteConfig(
          MyProfilePageRoute.name,
          path: '/my-profile-page',
        ),
        _i11.RouteConfig(
          EditOrderPageRoute.name,
          path: '/edit-order-page',
        ),
        _i11.RouteConfig(
          AboutPageRoute.name,
          path: '/about-page',
        ),
        _i11.RouteConfig(
          FrequentAskedQuestionPageRoute.name,
          path: '/frequent-asked-question-page',
        ),
        _i11.RouteConfig(
          MainPageRoute.name,
          path: '/main-page',
          children: [
            _i11.RouteConfig(
              HomePageRoute.name,
              path: 'home-page',
              parent: MainPageRoute.name,
            ),
            _i11.RouteConfig(
              SettingsPageRoute.name,
              path: 'settings-page',
              parent: MainPageRoute.name,
            ),
          ],
        ),
      ];
}

/// generated route for
/// [_i1.SplashPage]
class SplashPageRoute extends _i11.PageRouteInfo<void> {
  const SplashPageRoute()
      : super(
          SplashPageRoute.name,
          path: '/',
        );

  static const String name = 'SplashPageRoute';
}

/// generated route for
/// [_i2.LoginPage]
class LoginPageRoute extends _i11.PageRouteInfo<void> {
  const LoginPageRoute()
      : super(
          LoginPageRoute.name,
          path: '/login-page',
        );

  static const String name = 'LoginPageRoute';
}

/// generated route for
/// [_i3.SignUpPage]
class SignUpPageRoute extends _i11.PageRouteInfo<void> {
  const SignUpPageRoute()
      : super(
          SignUpPageRoute.name,
          path: '/sign-up-page',
        );

  static const String name = 'SignUpPageRoute';
}

/// generated route for
/// [_i4.MyProfilePage]
class MyProfilePageRoute extends _i11.PageRouteInfo<void> {
  const MyProfilePageRoute()
      : super(
          MyProfilePageRoute.name,
          path: '/my-profile-page',
        );

  static const String name = 'MyProfilePageRoute';
}

/// generated route for
/// [_i5.EditOrderPage]
class EditOrderPageRoute extends _i11.PageRouteInfo<EditOrderPageRouteArgs> {
  EditOrderPageRoute({
    _i12.Key? key,
    required _i13.Order order,
    required _i14.OrderDetails orderDetails,
  }) : super(
          EditOrderPageRoute.name,
          path: '/edit-order-page',
          args: EditOrderPageRouteArgs(
            key: key,
            order: order,
            orderDetails: orderDetails,
          ),
        );

  static const String name = 'EditOrderPageRoute';
}

class EditOrderPageRouteArgs {
  const EditOrderPageRouteArgs({
    this.key,
    required this.order,
    required this.orderDetails,
  });

  final _i12.Key? key;

  final _i13.Order order;

  final _i14.OrderDetails orderDetails;

  @override
  String toString() {
    return 'EditOrderPageRouteArgs{key: $key, order: $order, orderDetails: $orderDetails}';
  }
}

/// generated route for
/// [_i6.AboutPage]
class AboutPageRoute extends _i11.PageRouteInfo<void> {
  const AboutPageRoute()
      : super(
          AboutPageRoute.name,
          path: '/about-page',
        );

  static const String name = 'AboutPageRoute';
}

/// generated route for
/// [_i7.FrequentAskedQuestionPage]
class FrequentAskedQuestionPageRoute extends _i11.PageRouteInfo<void> {
  const FrequentAskedQuestionPageRoute()
      : super(
          FrequentAskedQuestionPageRoute.name,
          path: '/frequent-asked-question-page',
        );

  static const String name = 'FrequentAskedQuestionPageRoute';
}

/// generated route for
/// [_i8.MainPage]
class MainPageRoute extends _i11.PageRouteInfo<void> {
  const MainPageRoute({List<_i11.PageRouteInfo>? children})
      : super(
          MainPageRoute.name,
          path: '/main-page',
          initialChildren: children,
        );

  static const String name = 'MainPageRoute';
}

/// generated route for
/// [_i9.HomePage]
class HomePageRoute extends _i11.PageRouteInfo<void> {
  const HomePageRoute()
      : super(
          HomePageRoute.name,
          path: 'home-page',
        );

  static const String name = 'HomePageRoute';
}

/// generated route for
/// [_i10.SettingsPage]
class SettingsPageRoute extends _i11.PageRouteInfo<void> {
  const SettingsPageRoute()
      : super(
          SettingsPageRoute.name,
          path: 'settings-page',
        );

  static const String name = 'SettingsPageRoute';
}
