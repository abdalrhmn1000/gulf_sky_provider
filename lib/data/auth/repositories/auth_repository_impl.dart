import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:gulf_sky_provider/data/auth/datasources/local/auth_local_datasource.dart';
import 'package:gulf_sky_provider/data/auth/datasources/remote/auth_remote_datasource.dart';
import 'package:gulf_sky_provider/data/auth/models/user_model/user_model.dart';
import 'package:gulf_sky_provider/data/core/repositories/base_repository_impl.dart';
import 'package:gulf_sky_provider/data/core/utils/configuration.dart';
import 'package:gulf_sky_provider/data/user/models/enums/gender_model.dart';
import 'package:gulf_sky_provider/domain/auth/entities/user.dart';
import 'package:gulf_sky_provider/domain/auth/repositories/auth_repository.dart';
import 'package:gulf_sky_provider/domain/core/entities/failures.dart';
import 'package:gulf_sky_provider/domain/core/utils/network/network_info.dart';
import 'package:gulf_sky_provider/domain/user/entities/enums/gender.dart';
import 'package:gulf_sky_provider/domain/user/entities/user_info.dart';
import 'package:gulf_sky_provider/data/user/models/user_info_model/user_info_model.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl extends BaseRepositoryImpl implements AuthRepository {
  final AuthLocalDatasource local;
  final AuthRemoteDataSource remote;
  final NetworkInfo networkInfo;
  final Logger logger;
  final Configuration configuration;

  AuthRepositoryImpl(
    this.local,
    this.remote,
    this.networkInfo,
    this.logger,
    this.configuration,
  ) : super(networkInfo, logger);

  @override
  Future<Either<Failure, User?>> getSignedInUser() async {
    final UserModel? userModel = local.getSignedInUser();
    return right(userModel?.toDomain());
  }

  @override
  Future<Either<Failure, User>> login(
      {required String email, required String password}) async {
    return request(
      () async {
        var userResponse = await remote.login(email: email, password: password);
        local.signInUser(userResponse.data!);
        local.authStatus.add(userResponse.data!.userInfo);
        return right(userResponse.data!.toDomain());
      },
      checkToken: false,
    );
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    local.logout();
    local.authStatus.add(null);
    return right(unit);
  }

  @override
  Future<Either<Failure, Stream<UserInfo?>>> subscribeToAuthStatus() async {
    return right(local.authStatus.stream.map((event) => event?.toDomain()));
  }

  @override
  Future<Either<Failure, bool>> getIsFirstTimeLogged() async {
    return right(local.getIsFirstTimeLogged());
  }

  @override
  Future<Either<Failure, void>> setFirstTimeLogged(bool firstTimeLogged) async {
    return right(local.setFirstTimeLogged(firstTimeLogged));
  }

  @override
  Future<Either<Failure, User>> signUp(
      {required String email,
      required String firstName,
      required String lastName,
      required String phone,
      Gender? gender,
      required String password,
      File? profileImage,
      DateTime? dateOfBirth}) {
    return request(() async {
       await remote.signUp(
        email: email,
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        gender: genderModelFromDomainString(gender),
        password: password,
        profileImage: profileImage,
        dateOfBirth: dateOfBirth != null
            ? DateFormat("yyyy-MM-dd hh:mm:ss").format(dateOfBirth)
            : null,
      );
      var userResponse = await remote.login(email: email, password: password);
      local.signInUser(userResponse.data!);
      local.authStatus.add(userResponse.data!.userInfo);
      return right(userResponse.data!.toDomain());
    });
  }
}
