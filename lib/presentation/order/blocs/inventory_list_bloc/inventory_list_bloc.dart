import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:gulf_sky_provider/domain/core/usecases/usecase.dart';
import 'package:gulf_sky_provider/domain/order/entities/inventory.dart';
import 'package:gulf_sky_provider/domain/order/usecases/inventory_list_use_case.dart';
import 'package:gulf_sky_provider/presentation/core/blocs/core/base_state.dart';
import 'package:injectable/injectable.dart';
part 'inventory_list_event.dart';

@injectable
class InventoryListBloc extends Bloc<InventoryListEvent, BaseState<List<Inventory>>> {
  final InventoryListUseCase useCase;

  InventoryListBloc(
    this.useCase,
  ) : super(const BaseState()) {
    on<InventoryListRequested>(
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
