import 'package:intl/intl.dart';
import 'package:hijri/hijri_calendar.dart';

class DateHelper {
  static const Map<int, String> customHijriMonths = {
    1: "Muharram",
    2: "Safar",
    3: "Rabi'ul Awwal",
    4: "Rabi'ul Akhir",
    5: "Jumadil Awal",
    6: "Jumadil Akhir",
    7: "Rajab",
    8: "Sya'ban",
    9: "Ramadhan",
    10: "Syawal",
    11: "Dzulqa'dah",
    12: "Dzulhijjah",
  };

  static String getCustomHijriMonthName(HijriCalendar hijriDate) {
    return customHijriMonths[hijriDate.hMonth] ?? hijriDate.getLongMonthName();
  }

  static String formatGregorian(DateTime date,
      {String locale = 'en', String pattern = 'MMMM yyyy'}) {
    return DateFormat(pattern, locale).format(date);
  }

  static String convertToHijri(DateTime date,
      {String locale = 'en', String pattern = 'dd MMMM yyyy'}) {
    HijriCalendar.setLocal(locale);

    HijriCalendar hijriDate = HijriCalendar.fromDate(date);
    String monthName = getCustomHijriMonthName(hijriDate);

    int hijriDay = hijriDate.hDay;
    int hijriYear = hijriDate.hYear;

    if (pattern.contains('dd')) {
      pattern = pattern.replaceAll('dd', hijriDay.toString().padLeft(2, '0'));
    }
    if (pattern.contains('MMMM')) {
      pattern = pattern.replaceAll('MMMM', monthName);
    }
    if (pattern.contains('yyyy')) {
      pattern = pattern.replaceAll('yyyy', hijriYear.toString());
    }

    return pattern;
  }


  static String getHijriRangeForMonth(DateTime date) {
    final firstDayOfMonth = DateTime(date.year, date.month, 1);
    final lastDayOfMonth = DateTime(date.year, date.month + 1, 0);
    // print(firstDayOfMonth);
    // print(lastDayOfMonth);

    // Konversi ke Hijriyah
    final hijriStart = HijriCalendar.fromDate(firstDayOfMonth);
    final hijriEnd = HijriCalendar.fromDate(lastDayOfMonth);
    // Dapatkan nama bulan custom
    final startMonthName = getCustomHijriMonthName(hijriStart);
    final endMonthName = getCustomHijriMonthName(hijriEnd);

    // Jika bulan Hijriyah awal dan akhir sama
    if (hijriStart.hMonth == hijriEnd.hMonth &&
        hijriStart.hYear == hijriEnd.hYear) {
      return "$startMonthName ${hijriStart.hYear}";
    }

    // Logika penyesuaian tahun
    if (hijriStart.hYear == hijriEnd.hYear) {
      return "$startMonthName - $endMonthName ${hijriEnd.hYear}";
    } else {
      return "$startMonthName ${hijriStart.hYear} - $endMonthName ${hijriEnd.hYear}";
    }
  }
}
