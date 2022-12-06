import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:gulf_sky_provider/domain/order/entities/service.dart';
import 'package:gulf_sky_provider/domain/order/usecases/service_by_id_list_use_case.dart';
import 'package:gulf_sky_provider/presentation/core/blocs/core/base_state.dart';
import 'package:injectable/injectable.dart';

part 'service_by_id_event.dart';

@injectable
class ServiceByIdListBloc
    extends Bloc<ServiceByIdEvent, BaseState<Service>> {
  final ServiceByIdListUseCase useCase;

  ServiceByIdListBloc(
    this.useCase,
  ) : super(const BaseState()) {
    on<ServiceByIdRequested>(
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
