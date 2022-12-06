import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gulf_sky_provider/domain/order/usecases/update_order_details_use_case.dart';
import 'package:gulf_sky_provider/presentation/core/blocs/core/base_state.dart';
import 'package:injectable/injectable.dart';

part 'update_order_details_event.dart';

@Injectable()
class UpdateOrderDetailsBloc
    extends Bloc<UpdateOrderDetailsEvent, BaseState<String>> {
  final UpdateOrderDetailsUseCase updateOrderDetailsUseCase;

  UpdateOrderDetailsBloc(this.updateOrderDetailsUseCase)
      : super(const BaseState()) {
    on<UpdateOrderDetailsRequested>(
      (event, emit) async {
        emit(state.setInProgressState());
        final result = await updateOrderDetailsUseCase
            .call(UpdateOrderDetailsUseCaseParams(
          orderDetailId: event.orderDetailId,
          duration: event.duration,
          price: event.price,
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
