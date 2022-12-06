import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gulf_sky_provider/domain/user/entities/user_info.dart';
import 'package:gulf_sky_provider/presentation/core/auth/auth_bloc.dart';
import 'package:gulf_sky_provider/presentation/core/routes/router.gr.dart';
import 'package:gulf_sky_provider/presentation/core/utils/custom_dialog.dart';
import 'package:gulf_sky_provider/presentation/core/widgets/user_profile_widget.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  late final AuthBloc _authBloc;

  @override
  void initState() {
    _authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          DrawerHeader(
            child: GestureDetector(
              onTap: () {
                _navigateRoute(
                  const MyProfilePageRoute(),
                  context,
                );
              },
              child: _buildHeaderWidget(context),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  title: const Text('home').tr(),
                  onTap: () {
                    _navigateRoute(const HomePageRoute(), context);
                  },
                ),   ListTile(
                  leading: Icon(
                    Icons.question_mark_rounded,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  title: const Text('about').tr(),
                  onTap: () {
                    _navigateRoute(const AboutPageRoute(), context);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: Theme.of(context).errorColor,
                  ),
                  title: const Text('logout').tr(),
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
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }

  Widget _buildHeaderWidget(context) {
    return BlocBuilder<AuthBloc, AuthState>(
      bloc: _authBloc,
      builder: (context, state) {
        if (state is Authenticated) {
          final UserInfo user = state.user;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              UserProfileWidget(size: 48, profileUrl: user.profileImage),
              const SizedBox(
                height: 12,
              ),
              Text(
                user.fullName,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                user.email!,
              ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  void _navigateRoute(PageRouteInfo<void> page, context) {
    final String currentRouteName = AutoRouter.of(context).current.name;

    AutoRouter.of(context).pop();
    if (currentRouteName == page.routeName) {
      return;
    }
    if (page.routeName == HomePageRoute.name) {
      AutoRouter.of(context).navigate(const HomePageRoute());
      return;
    }
    if (currentRouteName == HomePageRoute.name) {
      AutoRouter.of(context).push(
        page,
      );
      return;
    } else {
      AutoRouter.of(context).popAndPush(page);
      return;
    }
  }
}
