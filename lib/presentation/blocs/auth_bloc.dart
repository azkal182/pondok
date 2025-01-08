import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pondok/data/models/auth_model.dart';
import 'package:pondok/domain/usecases/clear_auth_data_usecase.dart';
import 'package:pondok/domain/usecases/get_auth_data_usecase.dart';
import 'package:pondok/domain/usecases/login_usecase.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final GetAuthDataUseCase getAuthDataUseCase;
  final ClearAuthDataUsecase clearAuthDataUsecase;

  AuthBloc(
      this.loginUseCase, this.getAuthDataUseCase, this.clearAuthDataUsecase)
      : super(AuthInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<GetUserData>(_getUserDataUseCase);
    on<ClearAuthData>(_clearUserDataUseCase);
  }

  Future<void> _clearUserDataUseCase(
      ClearAuthData event, Emitter<AuthState> emit) async {
    emit(LoginLoading());
    try {
      await clearAuthDataUsecase();
      emit(AuthCleared());
    } catch (e) {
      emit(UserError('logout failed'));
    }
  }

  Future<void> _getUserDataUseCase(
      GetUserData event, Emitter<AuthState> emit) async {
    emit(LoginLoading());
    try {
      final result = await getAuthDataUseCase();
      if (result != null) {
        emit(UserLoaded(result));
      } else {
        emit(UserError('failed get user'));
      }
      // result.fold(
      //   (failure) => emit(LoginFailure(failure.toString())),
      //   (data) => emit(LoginSuccess(data)),
      // );
    } catch (e) {
      emit(UserError('failed get user'));
    }
  }

  Future<void> _onLoginSubmitted(
      LoginSubmitted event, Emitter<AuthState> emit) async {
    emit(LoginLoading());
    try {
      final result = await loginUseCase(event.username, event.password);

      result.fold(
        (failure) => emit(LoginFailure(failure.toString())),
        (data) => emit(LoginSuccess(data)),
      );
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
