import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pondok/core/utils/date.dart';

class CalendarList extends StatelessWidget {
  final Map<String, List<Map<String, dynamic>>> groupedEvents;

  const CalendarList({super.key, required this.groupedEvents});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: groupedEvents.length,
      itemBuilder: (context, index) {
        String key = groupedEvents.keys.elementAt(index);
        List<Map<String, dynamic>> events = groupedEvents[key]!;

        return Container(
          // margin: const EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              dividerColor:
                  Colors.transparent, // Hilangkan divider bawaan ExpansionTile
            ),
            child: ExpansionTile(
              key: PageStorageKey(key),
              title: Container(
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(width: 4, color: Colors.brown))),
                child: Text(
                  key.toUpperCase() == "HARI_SUNNAH"
                      ? "Puasa"
                      : "Hari Besar & Libur Nasional",
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              initiallyExpanded: true, // Expanded secara default
              tilePadding: const EdgeInsets.symmetric(horizontal: 16.0),

              collapsedBackgroundColor: Colors.transparent,
              backgroundColor: Colors.transparent, // Hilangkan warna tambahan
              children: List.generate(events.length, (eventIndex) {
                final event = events[eventIndex];
                return Column(
                  children: [
                    if (eventIndex == 0)
                      const Divider(
                        height: 2,
                        color: Colors.grey,
                        indent: 20,
                        endIndent: 20,
                      ), // Divider antar item
                    ListTile(
                      title: Text(
                        event['title'],
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      subtitle: Text(
                        '${DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(DateTime.parse(event['date']))} / ${DateHelper.convertToHijri(DateTime.parse(event['date']), pattern: "dd MMMM yyyy")} ',
                        style: TextStyle(fontSize: 12),
                      ),
                      leading: Container(
                        width: 50,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(7)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Memusatkan konten vertikal
                          crossAxisAlignment: CrossAxisAlignment
                              .center, // Memusatkan konten horizontal
                          children: [
                            Text(DateFormat('MMM')
                                .format(DateTime.parse(event['date']))),
                            Text(
                              DateFormat('d')
                                  .format(DateTime.parse(event['date'])),
                              style: TextStyle(
                                  color: _parseColor(event['dotColor']),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            )
                          ],
                        ),
                      ),
                    ),
                    if (eventIndex != events.length - 1)
                      const Divider(
                        height: 0.2,
                        color: Colors.grey,
                        indent: 80,
                        endIndent: 20,
                      ), // Divider antar item
                  ],
                );
              }),
            ),
          ),
        );
      },
    );
  }

  // Fungsi untuk mengonversi string warna menjadi Color
  Color _parseColor(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'orange':
        return Colors.orange;
      case 'red':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
