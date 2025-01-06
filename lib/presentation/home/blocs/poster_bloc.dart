import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/poster.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/usecases/get_posters.dart';

part 'poster_event.dart';
part 'poster_state.dart';

class PosterBloc extends Bloc<PosterEvent, PosterState> {
  final GetPosters getPosters;

  PosterBloc(this.getPosters) : super(PosterInitial()) {
    on<FetchPostersEvent>((event, emit) async {
      emit(PosterLoading());
      final result = await getPosters();
      result.fold(
        (failure) {
          if (kDebugMode) {
            print('BLoC Error: ${failure.runtimeType}');
          }
          emit(PosterError('Failed to load posters'));
        },
        (posters) => emit(PosterLoaded(posters)),
      );
    });
  }
}
