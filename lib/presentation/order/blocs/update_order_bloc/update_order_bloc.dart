import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gulf_sky_provider/domain/order/usecases/update_order_use_case.dart';
import 'package:gulf_sky_provider/presentation/core/blocs/core/base_state.dart';
import 'package:injectable/injectable.dart';

part 'update_order_event.dart';

@Injectable()
class UpdateOrderBloc extends Bloc<UpdateOrderEvent, BaseState<String>> {
  final UpdateOrderUseCase updateOrderUseCase;

  UpdateOrderBloc(this.updateOrderUseCase) : super(const BaseState()) {
    on<UpdateOrderRequested>(
      (event, emit) async {
        emit(state.setInProgressState());
        final result = await updateOrderUseCase.call(UpdateOrderUseCaseParams(
          orderId: event.orderId,
          date: event.date,
          notes: event.notes,
          time: event.time,
          image: event.image,
        ));

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
