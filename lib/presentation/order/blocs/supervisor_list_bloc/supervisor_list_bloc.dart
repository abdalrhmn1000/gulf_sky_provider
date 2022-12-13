import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:gulf_sky_provider/domain/core/usecases/usecase.dart';
import 'package:gulf_sky_provider/domain/order/usecases/supervisor_list_use_case.dart';
import 'package:gulf_sky_provider/domain/user/entities/user_info.dart';
import 'package:gulf_sky_provider/presentation/core/blocs/core/base_state.dart';
import 'package:injectable/injectable.dart';

part 'supervisor_list_event.dart';

@injectable
class SupervisorListBloc extends Bloc<SupervisorListEvent, BaseState<List<UserInfo>>> {
  final SupervisorListUseCase useCase;

  SupervisorListBloc(
    this.useCase,
  ) : super(const BaseState()) {
    on<SupervisorListRequested>(
      (event, emit) async {
        emit(state.setInProgressState());

        final result = await useCase(NoParams());
        result.fold(
          (l) => emit(state.setFailureState(l)),
          (r) {
            emit(
              state.setSuccessState(r),
            );
          },
        );
      },
    );
  }
}
