// Datasource
import 'package:pondok/core/utils/prayer_time.dart';
import 'package:pondok/data/models/prayer_time_model.dart';
import 'package:pondok/domain/entities/prayer_time.dart';

class PrayerTimesDataSource {
  Future<PrayerTimesEntity> fetchPrayerTimes(
      DateTime date, double latitude, double longitude, double timezone) async {
    PrayerTimes prayers = PrayerTimes();
    prayers.setTimeFormat(prayers.Time24);
    prayers.setCalcMethod(prayers.Kemenag);
    prayers.setAsrJuristic(prayers.Shafii);
    prayers.setAdjustHighLats(prayers.AngleBased);

    // Tuning offsets {fajr, sunrise, dhuhr, asr, sunset, maghrib, isha}
    var offsets = [2, 0, 2, 2, 0, 2, 2];
    prayers.tune(offsets);

    List<String> prayerTimes =
        prayers.getPrayerTimes(date, latitude, longitude, timezone);
    List<String> prayerNames = prayers.getTimeNames();

    List<PrayerTime> times = [];
    for (int i = 0; i < prayerTimes.length; i++) {
      times.add(PrayerTime(name: prayerNames[i], time: prayerTimes[i]));
    }

    return PrayerTimesEntity(prayerTimes: times);
  }
}
