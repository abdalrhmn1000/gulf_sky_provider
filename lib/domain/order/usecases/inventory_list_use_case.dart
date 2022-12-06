import 'package:dartz/dartz.dart';
import 'package:gulf_sky_provider/domain/core/entities/failures.dart';
import 'package:gulf_sky_provider/domain/core/usecases/usecase.dart';
import 'package:gulf_sky_provider/domain/order/entities/inventory.dart';
import 'package:gulf_sky_provider/domain/order/repositories/order_repository.dart';

import 'package:injectable/injectable.dart';

@lazySingleton
class InventoryListUseCase extends UseCase<List<Inventory>, NoParams> {
  final OrderRepository repository;

  InventoryListUseCase({required this.repository});

  @override
  Future<Either<Failure, List<Inventory>>> call(params) {
    return repository.getInventoryItems();
  }
}
