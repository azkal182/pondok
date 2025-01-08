part of 'balance_bloc.dart';

abstract class BalanceState extends Equatable {
  @override
  List<Object> get props => [];
}

class BalanceInitial extends BalanceState {}

class BalanceLoading extends BalanceState {}

class BalanceLoaded extends BalanceState {
  final BalanceModel balance;

  BalanceLoaded(this.balance);
}

class BalanceError extends BalanceState {
  final String message;

  BalanceError(this.message);
}
