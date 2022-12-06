part of 'update_order_bloc.dart';

@immutable
abstract class UpdateOrderEvent {}

class UpdateOrderRequested extends UpdateOrderEvent {
  final File? image;
  final int orderId;
  final String? notes;
  final String? date;
  final String? time;

  UpdateOrderRequested({
    required this.orderId,
    this.image,
    this.notes,
    this.date,
    this.time,
  });
}
