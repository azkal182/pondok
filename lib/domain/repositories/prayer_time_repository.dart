import 'package:pondok/domain/entities/prayer_time.dart';

abstract class PrayerTimesRepository {
  Future<PrayerTimesEntity> getPrayerTimes(
      DateTime date, double latitude, double longitude, double timezone);
}
