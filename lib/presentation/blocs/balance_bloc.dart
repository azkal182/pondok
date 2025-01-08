import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:pondok/data/models/balance_model.dart';
import 'package:pondok/domain/usecases/get_balance_usecase.dart';

part 'balance_event.dart';

part 'balance_state.dart';

class BalanceBloc extends Bloc<BalanceEvent, BalanceState> {
  final GetBalanceUsecase getBalance;

  BalanceBloc(this.getBalance) : super(BalanceInitial()) {
    on<GetBalanceEvent>((event, emit) async {
      emit(BalanceLoading());
      final result = await getBalance();
      result.fold((failure) => emit(BalanceError(failure.message)),
          (balance) => emit(BalanceLoaded(balance)));
    });
  }
}
