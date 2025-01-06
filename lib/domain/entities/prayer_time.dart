// Entity
import 'package:equatable/equatable.dart';
import 'package:pondok/data/models/prayer_time_model.dart';

class PrayerTimesEntity extends Equatable {
  final List<PrayerTime> prayerTimes;

  const PrayerTimesEntity({required this.prayerTimes});

  @override
  List<Object> get props => [prayerTimes];
}
