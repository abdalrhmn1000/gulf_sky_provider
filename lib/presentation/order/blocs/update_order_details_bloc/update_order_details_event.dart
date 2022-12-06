part of 'update_order_details_bloc.dart';

@immutable
abstract class UpdateOrderDetailsEvent {}

class UpdateOrderDetailsRequested extends UpdateOrderDetailsEvent {
  final int orderDetailId;
  final File? image;
  final double? price;
  final String? duration;

  UpdateOrderDetailsRequested({
    required this.orderDetailId,
    this.image,
    this.price,
    this.duration,
  });
}
