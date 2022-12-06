import 'dart:async';
import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gulf_sky_provider/data/auth/models/user_model/user_model.dart';
import 'package:gulf_sky_provider/data/core/utils/constants.dart';
import 'package:gulf_sky_provider/data/user/models/user_info_model/user_info_model.dart';

abstract class AuthLocalDatasource {
  Future<void> signInUser(UserModel user);

  UserModel? getSignedInUser();

  void logout();

  void updatePersonalInfo(UserInfoModel userInfoModel);

  void setFirstTimeLogged(bool firstTimeLogged);

  bool getIsFirstTimeLogged();

  StreamController<UserInfoModel?> get authStatus;

  void dispose();
}

@LazySingleton(as: AuthLocalDatasource)
class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  final SharedPreferences sharedPreferences;
  final StreamController<UserInfoModel?> _authStatusStream =
      StreamController<UserInfoModel?>.broadcast();

  AuthLocalDatasourceImpl(this.sharedPreferences);

  @override
  Future<void> signInUser(UserModel user) async {
    await sharedPreferences.setString(
      SharedPreferencesKeys.user,
      json.encode(user.toJson()),
    );
  }

  @override
  UserModel? getSignedInUser() {
    if (!sharedPreferences.containsKey(SharedPreferencesKeys.user)) return null;

    return UserModel.fromJson(
      json.decode(sharedPreferences.getString(SharedPreferencesKeys.user)!)
          as Map<String, dynamic>,
    );
  }

  @override
  void logout() {
    sharedPreferences.remove(SharedPreferencesKeys.user);
  }

  @override
  void updatePersonalInfo(UserInfoModel userInfoModel) async {
    final user = getSignedInUser();
    final updatedUser = UserModel(user!.accessToken, userInfoModel);
    await sharedPreferences.setString(
        SharedPreferencesKeys.user, json.encode(updatedUser.toJson()));
  }

  @override
  bool getIsFirstTimeLogged() {
    return sharedPreferences.getBool(SharedPreferencesKeys.isFirstTimeLogged) !=
        false;
  }

  @override
  void setFirstTimeLogged(bool firstTimeLogged) {
    sharedPreferences.setBool(
        SharedPreferencesKeys.isFirstTimeLogged, firstTimeLogged);
  }

  @override
  StreamController<UserInfoModel?> get authStatus => _authStatusStream;

  @override
  @disposeMethod
  void dispose() {
    _authStatusStream.close();
  }
}
