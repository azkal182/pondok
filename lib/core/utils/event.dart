class EventHelper {
  // Fungsi untuk mengelompokkan data berdasarkan key
  static Map<String, List<Map<String, dynamic>>> groupEvents(
      Map<String, dynamic> jsonData) {
    Map<String, List<Map<String, dynamic>>> groupedEvents = {
      "hari_nasional": [],
      "hari_sunnah": []
    };

    if (jsonData['events'] != null) {
      jsonData['events'].forEach((date, events) {
        for (var event in events) {
          if (event['key'] == 'hari_sunnah') {
            groupedEvents['hari_sunnah']?.add({'date': date, ...event});
          } else {
            groupedEvents['hari_nasional']?.add({'date': date, ...event});
          }
        }
      });
    }

    return groupedEvents;
  }
}
