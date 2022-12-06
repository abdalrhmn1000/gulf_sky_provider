import 'package:dartz/dartz.dart';
import 'package:gulf_sky_provider/domain/core/entities/failures.dart';

typedef FutureEitherFailureOrData<T> = Future<Either<Failure, T>> Function();

abstract class BaseRepository {
  Future<Either<Failure, T>> request<T>(FutureEitherFailureOrData<T> body,
      {bool checkToken = true});
}
