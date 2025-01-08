part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {
  final AuthModel user;

  LoginSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class LoginFailure extends AuthState {
  final String error;

  LoginFailure(this.error);

  @override
  List<Object> get props => [error];
}

class UserLoaded extends AuthState {
  final AuthModel user;

  UserLoaded(this.user);
}

class UserError extends AuthState {
  final String message;

  UserError(this.message);
}

class AuthCleared extends AuthState {}
