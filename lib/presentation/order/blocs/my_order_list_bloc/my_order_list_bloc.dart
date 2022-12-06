import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:gulf_sky_provider/domain/core/usecases/usecase.dart';
import 'package:gulf_sky_provider/domain/order/usecases/my_order_list_use_case.dart';
import 'package:gulf_sky_provider/presentation/core/blocs/core/base_state.dart';
import 'package:injectable/injectable.dart';

import 'package:gulf_sky_provider/domain/order/entities/order.dart' as order;
part 'my_order_list_event.dart';

@injectable
class MyOrderListBloc extends Bloc<MyOrderListEvent, BaseState<List<order.Order>>> {
  final MyOrderListUseCase useCase;

  MyOrderListBloc(
    this.useCase,
  ) : super(const BaseState()) {
    on<MyOrderListRequested>(
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
