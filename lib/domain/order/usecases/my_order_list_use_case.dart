import 'package:dartz/dartz.dart';
import 'package:gulf_sky_provider/domain/core/entities/failures.dart';
import 'package:gulf_sky_provider/domain/core/usecases/usecase.dart';
import 'package:gulf_sky_provider/domain/order/entities/order.dart' as order;
import 'package:gulf_sky_provider/domain/order/repositories/order_repository.dart';

import 'package:injectable/injectable.dart';

@lazySingleton
class MyOrderListUseCase extends UseCase<List<order.Order>, NoParams> {
  final OrderRepository repository;

  MyOrderListUseCase({required this.repository});

  @override
  Future<Either<Failure, List<order.Order>>> call(params) {
    return repository.getMyOrders();
  }
}
