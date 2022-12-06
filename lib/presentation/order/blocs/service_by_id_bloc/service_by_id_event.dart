part of 'service_by_id_bloc.dart';

@immutable
abstract class ServiceByIdEvent {}

class ServiceByIdRequested extends ServiceByIdEvent {
  final int id;

  ServiceByIdRequested({
    required this.id,
  });
}
