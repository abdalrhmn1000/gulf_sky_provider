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
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;

import '../../../domain/order/entities/order.dart' as _i10;
import '../../../domain/order/entities/order_details.dart' as _i11;
import '../../about/pages/about_page.dart' as _i7;
import '../../auth/pages/login_page.dart' as _i2;
import '../../auth/pages/my_profile_page.dart' as _i4;
import '../../auth/pages/sign_up_page.dart' as _i3;
import '../../home/pages/home_page.dart' as _i5;
import '../../order/pages/edit_order_page.dart' as _i6;
import '../pages/splash_page.dart' as _i1;

class AppRouter extends _i8.RootStackRouter {
  AppRouter([_i9.GlobalKey<_i9.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    SplashPageRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SplashPage(),
      );
    },
    LoginPageRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.LoginPage(),
      );
    },
    SignUpPageRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.SignUpPage(),
      );
    },
    MyProfilePageRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.MyProfilePage(),
      );
    },
    HomePageRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.HomePage(),
      );
    },
    EditOrderPageRoute.name: (routeData) {
      final args = routeData.argsAs<EditOrderPageRouteArgs>();
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i6.EditOrderPage(
          key: args.key,
          order: args.order,
          orderDetails: args.orderDetails,
        ),
      );
    },
    AboutPageRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.AboutPage(),
      );
    },
  };

  @override
  List<_i8.RouteConfig> get routes => [
        _i8.RouteConfig(
          SplashPageRoute.name,
          path: '/',
        ),
        _i8.RouteConfig(
          LoginPageRoute.name,
          path: '/login-page',
        ),
        _i8.RouteConfig(
          SignUpPageRoute.name,
          path: '/sign-up-page',
        ),
        _i8.RouteConfig(
          MyProfilePageRoute.name,
          path: '/my-profile-page',
        ),
        _i8.RouteConfig(
          HomePageRoute.name,
          path: '/home-page',
        ),
        _i8.RouteConfig(
          EditOrderPageRoute.name,
          path: '/edit-order-page',
        ),
        _i8.RouteConfig(
          AboutPageRoute.name,
          path: '/about-page',
        ),
      ];
}

/// generated route for
/// [_i1.SplashPage]
class SplashPageRoute extends _i8.PageRouteInfo<void> {
  const SplashPageRoute()
      : super(
          SplashPageRoute.name,
          path: '/',
        );

  static const String name = 'SplashPageRoute';
}

/// generated route for
/// [_i2.LoginPage]
class LoginPageRoute extends _i8.PageRouteInfo<void> {
  const LoginPageRoute()
      : super(
          LoginPageRoute.name,
          path: '/login-page',
        );

  static const String name = 'LoginPageRoute';
}

/// generated route for
/// [_i3.SignUpPage]
class SignUpPageRoute extends _i8.PageRouteInfo<void> {
  const SignUpPageRoute()
      : super(
          SignUpPageRoute.name,
          path: '/sign-up-page',
        );

  static const String name = 'SignUpPageRoute';
}

/// generated route for
/// [_i4.MyProfilePage]
class MyProfilePageRoute extends _i8.PageRouteInfo<void> {
  const MyProfilePageRoute()
      : super(
          MyProfilePageRoute.name,
          path: '/my-profile-page',
        );

  static const String name = 'MyProfilePageRoute';
}

/// generated route for
/// [_i5.HomePage]
class HomePageRoute extends _i8.PageRouteInfo<void> {
  const HomePageRoute()
      : super(
          HomePageRoute.name,
          path: '/home-page',
        );

  static const String name = 'HomePageRoute';
}

/// generated route for
/// [_i6.EditOrderPage]
class EditOrderPageRoute extends _i8.PageRouteInfo<EditOrderPageRouteArgs> {
  EditOrderPageRoute({
    _i9.Key? key,
    required _i10.Order order,
    required _i11.OrderDetails orderDetails,
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

  final _i9.Key? key;

  final _i10.Order order;

  final _i11.OrderDetails orderDetails;

  @override
  String toString() {
    return 'EditOrderPageRouteArgs{key: $key, order: $order, orderDetails: $orderDetails}';
  }
}

/// generated route for
/// [_i7.AboutPage]
class AboutPageRoute extends _i8.PageRouteInfo<void> {
  const AboutPageRoute()
      : super(
          AboutPageRoute.name,
          path: '/about-page',
        );

  static const String name = 'AboutPageRoute';
}
