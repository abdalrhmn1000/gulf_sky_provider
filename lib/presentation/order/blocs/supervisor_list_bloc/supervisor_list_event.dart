part of 'supervisor_list_bloc.dart';

@immutable
abstract class SupervisorListEvent {}

class SupervisorListRequested extends SupervisorListEvent {
  SupervisorListRequested();
}
