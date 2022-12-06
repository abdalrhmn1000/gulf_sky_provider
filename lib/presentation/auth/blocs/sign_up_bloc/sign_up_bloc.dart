import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:gulf_sky_provider/domain/auth/entities/user.dart';
import 'package:gulf_sky_provider/domain/auth/usecases/sign_up_use_case.dart';
import 'package:gulf_sky_provider/domain/user/entities/enums/gender.dart';
import 'package:gulf_sky_provider/presentation/core/blocs/core/base_state.dart';

part 'sign_up_event.dart';

@injectable
class SignUpBloc extends Bloc<SignUpEvent, BaseState<User>> {
  final SignUpUseCase signUpUseCase;

  SignUpBloc(this.signUpUseCase) : super(const BaseState()) {
    on<SignUpRequested>(
      (event, emit) async {
        emit(const BaseState(status: BaseStatus.inProgress));
        final result = await signUpUseCase.call(
          SignUpUseCaseParams(
            email: event.email,
            firstName: event.firstName,
            lastName: event.lastName,
            phone: event.phone,
            gender: event.gender,
            password: event.password,
            profileImage: event.profileImage,
            dateOfBirth: event.dateOfBirth,
          ),
        );
        emit(
          result.fold(
            (l) => state.setFailureState(l),
            (r) => state.setSuccessState(r),
          ),
        );
      },
    );
  }
}
