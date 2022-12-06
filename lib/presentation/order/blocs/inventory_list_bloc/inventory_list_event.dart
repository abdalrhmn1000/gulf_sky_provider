part of 'inventory_list_bloc.dart';

@immutable
abstract class InventoryListEvent {}

class InventoryListRequested extends InventoryListEvent {
  InventoryListRequested();
}
