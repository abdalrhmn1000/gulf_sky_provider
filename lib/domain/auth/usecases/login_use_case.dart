import 'package:dartz/dartz.dart';
import 'package:gulf_sky_provider/domain/auth/entities/user.dart';
import 'package:gulf_sky_provider/domain/auth/repositories/auth_repository.dart';
import 'package:gulf_sky_provider/domain/core/entities/failures.dart';
import 'package:gulf_sky_provider/domain/core/usecases/usecase.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LoginUseCase extends UseCase<User, LoginUseCaseParams> {
  final AuthRepository authRepository;

  LoginUseCase(this.authRepository);

  @override
  Future<Either<Failure, User>> call(LoginUseCaseParams params) async {
    return authRepository.login(email: params.email, password: params.password);
  }
}

class LoginUseCaseParams {
  final String email;
  final String password;

  LoginUseCaseParams({
    required this.email,
    required this.password,
  });
}
