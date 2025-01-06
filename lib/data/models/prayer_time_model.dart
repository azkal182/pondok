import 'package:equatable/equatable.dart';

class PrayerTime extends Equatable {
  final String name;
  final String time;

  const PrayerTime({required this.name, required this.time});

  @override
  List<Object> get props => [name, time];
}
