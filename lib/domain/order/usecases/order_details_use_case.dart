import 'package:dartz/dartz.dart';
import 'package:gulf_sky_provider/domain/core/entities/failures.dart';
import 'package:gulf_sky_provider/domain/core/usecases/usecase.dart';
import 'package:gulf_sky_provider/domain/order/entities/order_details.dart';
import 'package:gulf_sky_provider/domain/order/repositories/order_repository.dart';

import 'package:injectable/injectable.dart';

@lazySingleton
class OrderDetailsUseCase extends UseCase<List<OrderDetails>, int> {
  final OrderRepository repository;

  OrderDetailsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<OrderDetails>>> call(int params) {
    return repository.getOrderDetails(orderId: params);
  }
}
