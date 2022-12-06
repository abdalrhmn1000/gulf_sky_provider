import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gulf_sky_provider/domain/auth/entities/user.dart';
import 'package:gulf_sky_provider/domain/auth/usecases/login_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:gulf_sky_provider/presentation/core/blocs/core/base_state.dart';

part 'login_event.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, BaseState<User>> {
  final LoginUseCase login;

  LoginBloc({
    required this.login,
  }) : super(const BaseState()) {
    on<LoginRequested>(
      (event, emit) async {
        emit(state.setInProgressState());
        final result = await login(LoginUseCaseParams(
          email: event.email,
          password: event.password,
        ));
        result.fold(
          (l) {
            emit(state.setFailureState(l));
          },
          (user) {
            emit(state.setSuccessState(user));
          },
        );
      },
    );
  }
}
