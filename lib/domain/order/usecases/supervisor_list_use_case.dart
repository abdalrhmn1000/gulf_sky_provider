import 'package:dartz/dartz.dart';
import 'package:gulf_sky_provider/domain/core/entities/failures.dart';
import 'package:gulf_sky_provider/domain/core/usecases/usecase.dart';
import 'package:gulf_sky_provider/domain/order/repositories/order_repository.dart';
import 'package:gulf_sky_provider/domain/user/entities/user_info.dart';

import 'package:injectable/injectable.dart';

@lazySingleton
class SupervisorListUseCase extends UseCase<List<UserInfo>, NoParams> {
  final OrderRepository repository;

  SupervisorListUseCase({required this.repository});

  @override
  Future<Either<Failure, List<UserInfo>>> call(params) {
    return repository.getSupervisors();
  }
}
