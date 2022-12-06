part of 'sub_service_by_id_bloc.dart';

@immutable
abstract class SubServiceByIdEvent {}

class SubServiceByIdRequested extends SubServiceByIdEvent {
  final int id;

  SubServiceByIdRequested({
    required this.id,
  });
}
