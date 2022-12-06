import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:gulf_sky_provider/domain/order/entities/order_details.dart';
import 'package:gulf_sky_provider/domain/order/usecases/order_details_use_case.dart';
import 'package:gulf_sky_provider/presentation/core/blocs/core/base_state.dart';
import 'package:injectable/injectable.dart';
part 'order_details_event.dart';

@injectable
class OrderDetailsListBloc extends Bloc<OrderDetailsEvent, BaseState<List<OrderDetails>>> {
  final OrderDetailsUseCase useCase;

  OrderDetailsListBloc(
    this.useCase,
  ) : super(const BaseState()) {
    on<OrderDetailsRequested>(
      (event, emit) async {
        emit(state.setInProgressState());

        final result = await useCase(event.orderId);
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
