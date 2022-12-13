part of 'building_list_bloc.dart';

@immutable
abstract class BuildingListEvent {}

class BuildingListRequested extends BuildingListEvent {
  BuildingListRequested();
}
