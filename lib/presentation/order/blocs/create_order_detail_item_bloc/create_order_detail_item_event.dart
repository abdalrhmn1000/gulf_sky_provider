part of 'create_order_detail_item_bloc.dart';

@immutable
abstract class CreateOrderDetailItemEvent {}

class CreateOrderDetailItemRequested extends CreateOrderDetailItemEvent {
  final List<CreateOrderDetailItemUseCaseParams> items;
  CreateOrderDetailItemRequested({
    required this.items,
  });
}
