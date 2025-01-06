import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pondok/domain/entities/prayer_time.dart';
import 'package:pondok/domain/repositories/prayer_time_repository.dart';

part 'prayer_times_event.dart';
part 'prayer_times_state.dart';

class PrayerTimesBloc extends Bloc<PrayerTimesEvent, PrayerTimesState> {
  final PrayerTimesRepository repository;

  PrayerTimesBloc(this.repository) : super(PrayerTimesInitial()) {
    on<LoadPrayerTimes>((event, emit) async {
      emit(PrayerTimesLoading());
      try {
        final prayerTimes = await repository.getPrayerTimes(
          event.date,
          event.latitude,
          event.longitude,
          event.timezone,
        );
        emit(PrayerTimesLoaded(prayerTimes));
      } catch (e) {
        emit(PrayerTimesError(e.toString()));
      }
    });
  }
}
