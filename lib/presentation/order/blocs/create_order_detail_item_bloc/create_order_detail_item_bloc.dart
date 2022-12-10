import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gulf_sky_provider/domain/order/usecases/create_order_detail_item_use_case.dart';
import 'package:gulf_sky_provider/presentation/core/blocs/core/base_state.dart';
import 'package:injectable/injectable.dart';

part 'create_order_detail_item_event.dart';

@Injectable()
class CreateOrderDetailItemBloc
    extends Bloc<CreateOrderDetailItemEvent, BaseState<String>> {
  final CreateOrderDetailItemUseCase createOrderDetailItemUseCase;

  CreateOrderDetailItemBloc(this.createOrderDetailItemUseCase)
      : super(const BaseState()) {
    on<CreateOrderDetailItemRequested>(
      (event, emit) async {
        emit(state.setInProgressState());
        final result = await createOrderDetailItemUseCase
            .call(event.items);

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
