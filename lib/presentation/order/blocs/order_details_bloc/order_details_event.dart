part of 'order_details_bloc.dart';

@immutable
abstract class OrderDetailsEvent {}

class OrderDetailsRequested extends OrderDetailsEvent {
  final int orderId;

  OrderDetailsRequested({
    required this.orderId,
  });
}
