import 'package:dartz/dartz.dart';
import 'package:gulf_sky_provider/domain/core/entities/failures.dart';
import 'package:gulf_sky_provider/domain/core/usecases/usecase.dart';
import 'package:gulf_sky_provider/domain/order/entities/building.dart';
import 'package:gulf_sky_provider/domain/order/repositories/order_repository.dart';

import 'package:injectable/injectable.dart';

@lazySingleton
class BuildingListUseCase extends UseCase<List<Building>, NoParams> {
  final OrderRepository repository;

  BuildingListUseCase({required this.repository});

  @override
  Future<Either<Failure, List<Building>>> call(params) {
    return repository.getBuildings();
  }
}
