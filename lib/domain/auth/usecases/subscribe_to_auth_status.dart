import 'package:dartz/dartz.dart';
import 'package:gulf_sky_provider/domain/auth/repositories/auth_repository.dart';
import 'package:gulf_sky_provider/domain/core/entities/failures.dart';
import 'package:gulf_sky_provider/domain/core/usecases/usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:gulf_sky_provider/domain/user/entities/user_info.dart';

@lazySingleton
class SubscribeToAuthStatusUseCase
    extends UseCase<Stream<UserInfo?>, NoParams> {
  final AuthRepository authRepository;

  SubscribeToAuthStatusUseCase(this.authRepository);

  @override
  Future<Either<Failure, Stream<UserInfo?>>> call(NoParams params) async {
    return authRepository.subscribeToAuthStatus();
  }
}
