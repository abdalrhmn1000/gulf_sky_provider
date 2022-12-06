part of 'my_order_list_bloc.dart';

@immutable
abstract class MyOrderListEvent {}

class MyOrderListRequested extends MyOrderListEvent {
  MyOrderListRequested();
}
