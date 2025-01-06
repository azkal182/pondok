part of 'prayer_times_bloc.dart';

abstract class PrayerTimesEvent extends Equatable {
  const PrayerTimesEvent();

  @override
  List<Object> get props => [];
}

class LoadPrayerTimes extends PrayerTimesEvent {
  final DateTime date;
  final double latitude;
  final double longitude;
  final double timezone;

  const LoadPrayerTimes({
    required this.date,
    required this.latitude,
    required this.longitude,
    required this.timezone,
  });

  @override
  List<Object> get props => [date, latitude, longitude, timezone];
}
