import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:gulf_sky_provider/domain/core/entities/failures.dart';
import 'package:gulf_sky_provider/domain/core/usecases/usecase.dart';
import 'package:gulf_sky_provider/domain/order/repositories/order_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UpdateOrderUseCase extends UseCase<String, UpdateOrderUseCaseParams> {
  final OrderRepository repository;

  UpdateOrderUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, String>> call(UpdateOrderUseCaseParams params) {
    return repository.updateOrder(
      orderId: params.orderId,
      image: params.image,
      notes: params.notes,
      date: params.date,
      time: params.time,
    );
  }
}

class UpdateOrderUseCaseParams {
  final File? image;
  final int orderId;
  final String? notes;
  final String? date;
  final String? time;

  UpdateOrderUseCaseParams({
    required this.orderId,
    this.image,
    this.notes,
    this.date,
    this.time,
  });
}
