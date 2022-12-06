import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:gulf_sky_provider/domain/order/entities/service.dart';
import 'package:gulf_sky_provider/domain/order/usecases/sub_service_by_id_list_use_case.dart';
import 'package:gulf_sky_provider/presentation/core/blocs/core/base_state.dart';
import 'package:injectable/injectable.dart';

part 'sub_service_by_id_event.dart';

@injectable
class SubServiceByIdListBloc
    extends Bloc<SubServiceByIdEvent, BaseState<Service>> {
  final SubServiceByIdListUseCase useCase;

  SubServiceByIdListBloc(
    this.useCase,
  ) : super(const BaseState()) {
    on<SubServiceByIdRequested>(
      (event, emit) async {
        emit(state.setInProgressState());

        final result = await useCase(event.id);
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
