import 'package:dartz/dartz.dart';
import 'package:gulf_sky_provider/domain/auth/repositories/auth_repository.dart';
import 'package:gulf_sky_provider/domain/core/entities/failures.dart';
import 'package:gulf_sky_provider/domain/core/usecases/usecase.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LogoutUseCase extends UseCase<Unit, NoParams> {
  final AuthRepository repository;

  LogoutUseCase({required this.repository});

  @override
  Future<Either<Failure, Unit>> call(NoParams params) {
    return repository.logout();
  }
}
