import 'package:dartz/dartz.dart';
import 'package:gulf_sky_provider/domain/core/entities/failures.dart';
import 'package:gulf_sky_provider/domain/core/usecases/usecase.dart';
import 'package:gulf_sky_provider/domain/order/entities/service.dart';
import 'package:gulf_sky_provider/domain/order/repositories/order_repository.dart';

import 'package:injectable/injectable.dart';

@lazySingleton
class ServiceByIdListUseCase extends UseCase<Service, int> {
  final OrderRepository repository;

  ServiceByIdListUseCase({required this.repository});

  @override
  Future<Either<Failure, Service>> call(int params) {
    return repository.getServiceById(id: params);
  }
}
