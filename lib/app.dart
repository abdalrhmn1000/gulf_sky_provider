import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gulf_sky_provider/presentation/order/blocs/building_list_bloc/building_list_bloc.dart';
import 'package:gulf_sky_provider/presentation/order/blocs/supervisor_list_bloc/supervisor_list_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:gulf_sky_provider/injection.dart';
import 'package:gulf_sky_provider/presentation/core/resources/theme.dart';
import 'package:gulf_sky_provider/presentation/core/routes/router.dart';

import 'presentation/core/auth/auth_bloc.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) =>
              getIt<AuthBloc>()..add(SubscribeToAuthStatus()),
        ),
        BlocProvider(
            create: (BuildContext context) => getIt<BuildingListBloc>()),
        BlocProvider(
            create: (BuildContext context) => getIt<SupervisorListBloc>()),
      ],
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: MaterialApp.router(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          theme: getThemeData(context),
          themeMode: ThemeMode.light,
          builder: (context, widget) {
            return BlocListener<AuthBloc, AuthState>(
              listenWhen: (s1, s2) => s1.runtimeType != s2.runtimeType,
              listener: (context, state) async {
                if (state is Authenticated) {
                  BlocProvider.of<BuildingListBloc>(context).add(
                    BuildingListRequested(),
                  );
                  BlocProvider.of<SupervisorListBloc>(context).add(
                    SupervisorListRequested(),
                  );
                  _appRouter.pushAndPopUntil(const MainPageRoute(),
                      predicate: (route) => false);
                }
                if (state is Unauthenticated) {
                  _appRouter.pushAndPopUntil(
                    const LoginPageRoute(),
                    predicate: (r) => false,
                  );
                }
              },
              child: Builder(
                builder: (context) {
                  if (widget == null) {
                    return Container();
                  }
                  return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      child: ResponsiveWrapper.builder(
                        BouncingScrollWrapper.builder(
                            context,
                            SafeArea(
                              top: false,
                              left: false,
                              right: false,
                              child: widget,
                            )),
                        maxWidth: 1200,
                        minWidth: 480,
                        defaultScale: true,
                        breakpoints: const [
                          ResponsiveBreakpoint.resize(480, name: MOBILE),
                          ResponsiveBreakpoint.autoScale(800, name: TABLET),
                          ResponsiveBreakpoint.resize(1000, name: DESKTOP),
                        ],
                        //background: Container(color: kWebBG),
                      ));
                },
              ),
            );
          },
          routerDelegate: _appRouter.delegate(),
          routeInformationParser: _appRouter.defaultRouteParser(),
        ),
      ),
    );
  }
}
