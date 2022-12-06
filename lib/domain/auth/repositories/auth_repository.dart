import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:gulf_sky_provider/domain/auth/entities/user.dart';
import 'package:gulf_sky_provider/domain/core/entities/failures.dart';
import 'package:gulf_sky_provider/domain/user/entities/enums/gender.dart';
import 'package:gulf_sky_provider/domain/user/entities/user_info.dart';

abstract class AuthRepository {
  Future<Either<Failure, User?>> getSignedInUser();

  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, Unit>> logout();

  Future<Either<Failure, Stream<UserInfo?>>> subscribeToAuthStatus();

  Future<Either<Failure, bool>> getIsFirstTimeLogged();

  Future<Either<Failure, void>> setFirstTimeLogged(bool firstTimeLogged);

  Future<Either<Failure, User>> signUp({
    required String email,
    required String firstName,
    required String lastName,
    required String phone,
    Gender? gender,
    required String password,
    File? profileImage,
    DateTime? dateOfBirth,
  });
}
