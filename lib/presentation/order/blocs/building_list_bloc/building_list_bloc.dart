import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:gulf_sky_provider/domain/core/usecases/usecase.dart';
import 'package:gulf_sky_provider/domain/order/entities/building.dart';
import 'package:gulf_sky_provider/domain/order/usecases/building_list_use_case.dart';
import 'package:gulf_sky_provider/presentation/core/blocs/core/base_state.dart';
import 'package:injectable/injectable.dart';

part 'building_list_event.dart';

@injectable
class BuildingListBloc extends Bloc<BuildingListEvent, BaseState<List<Building>>> {
  final BuildingListUseCase useCase;

  BuildingListBloc(
    this.useCase,
  ) : super(const BaseState()) {
    on<BuildingListRequested>(
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
