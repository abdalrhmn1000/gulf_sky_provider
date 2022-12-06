import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:gulf_sky_provider/domain/core/entities/failures.dart';
import 'package:gulf_sky_provider/domain/core/usecases/usecase.dart';
import 'package:gulf_sky_provider/domain/order/repositories/order_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UpdateOrderDetailsUseCase
    extends UseCase<String, UpdateOrderDetailsUseCaseParams> {
  final OrderRepository repository;

  UpdateOrderDetailsUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, String>> call(UpdateOrderDetailsUseCaseParams params) {
    return repository.updateOrderDetails(
      orderDetailId: params.orderDetailId,
      image: params.image,
      price: params.price,
      duration: params.duration,
    );
  }
}

class UpdateOrderDetailsUseCaseParams {
  final int orderDetailId;
  final File? image;
  final double? price;
  final String? duration;

  UpdateOrderDetailsUseCaseParams({
    required this.orderDetailId,
    this.image,
    this.price,
    this.duration,
  });
}
