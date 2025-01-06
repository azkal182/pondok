import 'package:pondok/data/datasource/local/prayer_time_datasorce.dart';
import 'package:pondok/domain/entities/prayer_time.dart';
import 'package:pondok/domain/repositories/prayer_time_repository.dart';

class PrayerTimesRepositoryImpl implements PrayerTimesRepository {
  final PrayerTimesDataSource dataSource;

  PrayerTimesRepositoryImpl(this.dataSource);

  @override
  Future<PrayerTimesEntity> getPrayerTimes(DateTime date, double latitude, double longitude, double timezone) {
    return dataSource.fetchPrayerTimes(date, latitude, longitude, timezone);
  }
}