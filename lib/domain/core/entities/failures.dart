import 'package:gulf_sky_provider/domain/core/utils/constants.dart';

abstract class Failure {}

class ServerFailure implements Failure {
  final ServerErrorCode errorCode;
  final String message;

  ServerFailure({required this.errorCode, this.message = ''});
}


class AppAccessDeniedFailure implements Failure {}
