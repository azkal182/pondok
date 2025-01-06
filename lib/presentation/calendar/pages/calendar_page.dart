import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pondok/core/utils/date.dart';
import 'package:pondok/core/utils/day_in_range.dart';
import 'package:pondok/core/utils/event.dart';
import 'package:pondok/core/utils/pasaran_jawa.dart';
import 'package:pondok/presentation/calendar/widgets/calendar_list.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:hijri/hijri_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  Map<DateTime, List<Event>> events = {};
  final RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  DateTime _currentMonth = DateTime.now();

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    // _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    _selectedEvents = ValueNotifier<List<Event>>([]);

    // Simulasi event untuk beberapa hari dengan title dan description
    events = {
      DateTime(2024, 11, 19): [
        Event(title: "Event 1", description: 'Test description 1'),
        Event(title: "Event 2", description: 'Test description 2')
      ],
      DateTime(2024, 11, 20): [
        Event(title: "Event 3", description: 'Test description 3')
      ],
      DateTime(2024, 11, 21): [
        Event(title: "Event 4", description: 'Test description 4'),
        Event(title: "Event 5", description: 'Test description 5')
      ],
      DateTime(2024, 11, 25): [
        Event(title: "Event 6", description: 'Test description 6')
      ],
      DateTime(2024, 11, 27): [
        Event(title: "Event 7", description: 'Test description 7')
      ],
    };

    // Menampilkan event berdasarkan bulan yang dipilih
    _updateEventsForMonth(_currentMonth);
    loadPreviousEvents();
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  // Fungsi untuk memperbarui daftar event berdasarkan bulan yang dipilih
  void _updateEventsForMonth(DateTime month) {
    final startOfMonth = DateTime(month.year, month.month, 1);
    final endOfMonth =
        DateTime(month.year, month.month + 1, 0); // Hari terakhir bulan

    final eventsForMonth = <Event>[];
    events.forEach((date, eventList) {
      if (date.isAfter(startOfMonth.subtract(Duration(days: 1))) &&
          date.isBefore(endOfMonth.add(Duration(days: 1)))) {
        eventsForMonth.addAll(eventList);
      }
    });

    _selectedEvents.value = eventsForMonth;
  }

//*GET EVENTS PER DAY
  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

//*GET EVENT RANGE
  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    final days = daysInRange(start, end);
    return [
      for (final day in days) ..._getEventsForDay(day),
    ];
  }

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  void clearController() {
    _titleController.clear();
    _descriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    HijriCalendar.setLocal('en');
    final jsonData = {
      "message": "success",
      "events": {
        "2024-01-01": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          },
          {
            "key": "hari_libur_nasional",
            "dotColor": "red",
            "title": "tahun baru 2024"
          }
        ],
        "2024-01-04": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-01-08": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ],
        "2024-01-11": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-01-15": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ],
        "2024-01-18": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-01-22": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ],
        "2024-01-25": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-01-29": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ],
        "2024-02-01": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-02-05": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ],
        "2024-02-08": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-02-12": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ],
        "2024-02-15": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-02-19": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ],
        "2024-02-22": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-02-26": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ],
        "2024-02-29": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-03-04": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ],
        "2024-03-07": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-03-11": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ],
        "2024-03-14": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-03-18": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ],
        "2024-03-21": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-03-25": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ],
        "2024-03-28": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-04-01": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ],
        "2024-04-04": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-04-08": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ],
        "2024-04-11": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-04-15": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ],
        "2024-04-18": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-04-22": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ],
        "2024-04-25": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-04-29": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ],
        "2024-05-02": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-05-06": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ],
        "2024-05-09": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-05-13": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ],
        "2024-05-16": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-05-20": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ],
        "2024-05-23": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-05-27": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ],
        "2024-05-30": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-06-03": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ],
        "2024-06-06": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-06-10": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ],
        "2024-06-13": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-06-17": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ],
        "2024-06-20": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-06-24": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ],
        "2024-06-27": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-07-01": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ],
        "2024-07-04": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-07-07": [
          {
            "key": "hari_libur_nasional",
            "dotColor": "red",
            "title": "tahun baru hijriyah 1446"
          }
        ],
        "2024-07-08": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ],
        "2024-07-11": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-07-15": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ],
        "2024-07-18": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-07-22": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ],
        "2024-07-25": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-07-29": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ],
        "2024-08-01": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-08-05": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ],
        "2024-08-08": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-08-12": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ],
        "2024-08-15": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-08-19": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ],
        "2024-08-22": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-08-26": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ],
        "2024-08-29": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-09-02": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ],
        "2024-09-05": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-09-09": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ],
        "2024-09-12": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-09-16": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ],
        "2024-09-19": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-09-23": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ],
        "2024-09-26": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-09-30": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ],
        "2024-10-03": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-10-07": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ],
        "2024-10-10": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-10-14": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ],
        "2024-10-17": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-10-21": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ],
        "2024-10-22": [
          {
            "key": "hari_libur_nasional",
            "dotColor": "red",
            "title": "Hari santri "
          }
        ],
        "2024-10-24": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-10-28": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ],
        "2024-10-31": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-11-04": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ],
        "2024-11-07": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-11-11": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ],
        "2024-11-14": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-11-18": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ],
        "2024-11-21": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-11-25": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ],
        "2024-11-28": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-12-02": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ],
        "2024-12-05": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-12-09": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ],
        "2024-12-12": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-12-16": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ],
        "2024-12-19": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-12-23": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ],
        "2024-12-25": [
          {
            "key": "hari_libur_nasional",
            "dotColor": "red",
            "title": "Hari Natal "
          }
        ],
        "2024-12-26": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah kamis "
          }
        ],
        "2024-12-30": [
          {
            "key": "hari_sunnah",
            "dotColor": "orange",
            "title": "puasa sunnah senin "
          }
        ]
      }
    };

    // Mengelompokkan data
    final groupedEvents = EventHelper.groupEvents(jsonData);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                '${DateFormat('EEEE', 'id_ID').format(_focusedDay)} ${convertDateToPasaranJawa(_focusedDay)}, ${DateFormat('dd MMMM yyyy', 'id_ID').format(_focusedDay)}',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: Theme.of(context).colorScheme.onPrimary)),
            Text(
                DateHelper.convertToHijri(_focusedDay, pattern: "dd MMMM yyyy"),
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: Theme.of(context).colorScheme.onPrimary)),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(10),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  _navigateToPreviousMonth();
                },
              ),
              // Centered Text showing Month and Year
              Expanded(
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        DateFormat('MMMM yyyy', 'id_ID').format(_currentMonth),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        DateHelper.getHijriRangeForMonth(_currentMonth),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  _navigateToNextMonth();
                },
              )
            ]),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: kBottomNavigationBarHeight + 40),
              child: Column(
                children: [
                  TableCalendar(
                    availableGestures: AvailableGestures.none,
                    rowHeight: 60,
                    headerVisible: false,
                    locale: 'id_ID',
                    headerStyle: HeaderStyle(
                        formatButtonDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(),
                            color: Theme.of(context)
                                .colorScheme
                                .tertiaryContainer),
                        decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .onInverseSurface)),
                    firstDay: DateTime.utc(2000, 12, 31),
                    lastDay: DateTime.utc(2030, 01, 01),
                    focusedDay: _focusedDay,
                    selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                    rangeStartDay: _rangeStart,
                    rangeEndDay: _rangeEnd,
                    calendarFormat: _calendarFormat,
                    rangeSelectionMode: _rangeSelectionMode,
                    eventLoader: _getEventsForDay,
                    startingDayOfWeek: StartingDayOfWeek.sunday,
                    daysOfWeekHeight: 30,
                    calendarStyle: CalendarStyle(
                      markerDecoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer),
                          color: Theme.of(context).colorScheme.primary),
                      todayDecoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary),
                      // Use `CalendarStyle` to customize the UI
                      outsideDaysVisible: true,
                    ),
                    onDaySelected: _onDaySelected,

                    calendarBuilders: CalendarBuilders(
                      selectedBuilder: (context, date, events) {
                        HijriCalendar today = HijriCalendar.fromDate(date);
                        Color dayColor;
                        if (date.weekday == DateTime.sunday) {
                          dayColor = Colors.red; // Warna untuk hari Minggu
                        } else if (date.weekday == DateTime.friday) {
                          dayColor = Colors.green; // Warna untuk hari Jumat
                        } else {
                          dayColor = Theme.of(context)
                              .colorScheme
                              .onSurface; // Default warna
                        }
                        return Container(
                          margin: const EdgeInsets.all(0),
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSameDay(_selectedDay, date)
                                ? Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.3)
                                : Colors.white,
                            border: Border.all(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary, //                   <--- border color
                              width: 2,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    NumberFormat('#.##', 'ar_EG')
                                        .format(today.hDay),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 1,
                                  ),
                                  Text(
                                    '${date.day}',
                                    style: TextStyle(
                                        color: dayColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 1),
                              Text(
                                convertDateToPasaranJawa(date),
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey),
                              ),
                              SizedBox(
                                height: 1,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 7,
                                    width: 7,
                                    decoration: const BoxDecoration(
                                        color: Colors.orange,
                                        shape: BoxShape.circle),
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Container(
                                    height: 7,
                                    width: 7,
                                    decoration: const BoxDecoration(
                                        color: Colors.blue,
                                        shape: BoxShape.circle),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                      todayBuilder: (context, date, events) {
                        HijriCalendar today = HijriCalendar.fromDate(date);
                        Color dayColor;
                        if (date.weekday == DateTime.sunday) {
                          dayColor = Colors.red; // Warna untuk hari Minggu
                        } else if (date.weekday == DateTime.friday) {
                          dayColor = Colors.green; // Warna untuk hari Jumat
                        } else {
                          dayColor = Theme.of(context)
                              .colorScheme
                              .onSurface; // Default warna
                        }
                        return Container(
                          margin: const EdgeInsets.all(0),
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.3),
                            border: Border.all(
                              color: Colors
                                  .grey, //                   <--- border color
                              width: 0.2,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    NumberFormat('#.##', 'ar_EG')
                                        .format(today.hDay),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 1,
                                  ),
                                  Text(
                                    '${date.day}',
                                    style: TextStyle(
                                        color: dayColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 1),
                              Text(
                                convertDateToPasaranJawa(date),
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey),
                              ),
                              SizedBox(
                                height: 1,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 7,
                                    width: 7,
                                    decoration: const BoxDecoration(
                                        color: Colors.orange,
                                        shape: BoxShape.circle),
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Container(
                                    height: 7,
                                    width: 7,
                                    decoration: const BoxDecoration(
                                        color: Colors.blue,
                                        shape: BoxShape.circle),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                      outsideBuilder: (context, date, events) {
                        return Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors
                                    .grey, // Border warna abu-abu untuk tanggal yang disabled
                                width: 0.2,
                              ),
                              color: Colors
                                  .white, // Warna background untuk disabled
                            ),
                            child: Text('${date.day}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(color: Colors.grey)));
                      },
                      defaultBuilder: (context, date, events) {
                        // Custom day widget with additional text
                        HijriCalendar today = HijriCalendar.fromDate(date);
                        Color dayColor;
                        if (date.weekday == DateTime.sunday) {
                          dayColor = Colors.red; // Warna untuk hari Minggu
                        } else if (date.weekday == DateTime.friday) {
                          dayColor = Colors.teal; // Warna untuk hari Jumat
                        } else {
                          dayColor = Theme.of(context)
                              .colorScheme
                              .onSurface; // Default warna
                        }

                        return Container(
                          margin: const EdgeInsets.all(0),
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors
                                  .grey, //                   <--- border color
                              width: 0.2,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    NumberFormat('#.##', 'ar_EG')
                                        .format(today.hDay),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            fontSize: 14, color: dayColor),
                                  ),
                                  Text('${date.day}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(
                                              fontSize: 20, color: dayColor)),
                                ],
                              ),
                              const SizedBox(height: 1),
                              Text(
                                convertDateToPasaranJawa(date),
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey),
                              ),
                              SizedBox(
                                height: 1,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 7,
                                    width: 7,
                                    decoration: const BoxDecoration(
                                        color: Colors.orange,
                                        shape: BoxShape.circle),
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Container(
                                    height: 7,
                                    width: 7,
                                    decoration: const BoxDecoration(
                                        color: Colors.blue,
                                        shape: BoxShape.circle),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                      dowBuilder: (context, date) {
                        String dayName = DateFormat('EEEE', 'id_ID')
                            .format(date); // Mendapatkan nama hari

                        // Mempersonalisasi nama hari sesuai keinginan
                        switch (dayName) {
                          case 'Minggu':
                            dayName = 'Ahad'; // Ganti Minggu menjadi Ahad
                            break;
                          case 'Senin':
                            dayName = 'Senin';
                            break;
                          case 'Selasa':
                            dayName = 'Selasa';
                            break;
                          case 'Rabu':
                            dayName = 'Rabu';
                            break;
                          case 'Kamis':
                            dayName = 'Kamis';
                            break;
                          case 'Jumat':
                            dayName = 'Jumat';
                            break;
                          case 'Sabtu':
                            dayName = 'Sabtu';
                            break;
                        }

                        return Container(
                          color: Colors
                              .transparent, // Ganti dengan warna yang Anda inginkan
                          alignment: Alignment.center,
                          child: Text(
                            dayName,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                    fontSize: 14, fontWeight: FontWeight.w200),
                          ),
                        );
                      },
                    ),
                    onFormatChanged: (format) {
                      if (_calendarFormat != format) {
                        setState(() {
                          _calendarFormat = format;
                        });
                      }
                    },
                    onPageChanged: (focusedDay) {
                      _focusedDay = focusedDay;
                      _currentMonth =
                          DateTime(focusedDay.year, focusedDay.month);
                    },
                    // Ici, vous pouvez personnaliser l'apparence et le comportement du calendrier selon vos besoins
                  ),
                  const SizedBox(height: 15.0),
                  CalendarList(groupedEvents: groupedEvents)

                  // Container(
                  //   padding: const EdgeInsets.only(top: 10),
                  //   decoration: BoxDecoration(
                  //       color: Theme.of(context).colorScheme.onInverseSurface),
                  //   child: ValueListenableBuilder(
                  //     builder: (context, value, _) {
                  //
                  //       // return Column(
                  //       //   mainAxisSize: MainAxisSize.min,
                  //       //   children: value
                  //       //       .map((e) => Container(
                  //       //         // margin: const EdgeInsets.symmetric(
                  //       //         //     vertical: 20, horizontal: 14),
                  //       //         decoration: BoxDecoration(
                  //       //             borderRadius: BorderRadius.circular(4)),
                  //       //         child: Column(
                  //       //           children: [
                  //       //             Row(
                  //       //               mainAxisAlignment:
                  //       //               MainAxisAlignment.spaceBetween,
                  //       //               children: [
                  //       //                 Icon(
                  //       //                   Icons.check_box,
                  //       //                   color: Theme.of(context)
                  //       //                       .buttonTheme
                  //       //                       .colorScheme!
                  //       //                       .secondary,
                  //       //                 ),
                  //       //                 SizedBox(
                  //       //                   child: Column(
                  //       //                     children: [
                  //       //                       SizedBox(
                  //       //                           child: Column(children: [
                  //       //                             Text(
                  //       //                                 maxLines: 1,
                  //       //                                 style: const TextStyle(
                  //       //                                     fontWeight:
                  //       //                                     FontWeight.w500,
                  //       //                                     fontSize: 16),
                  //       //                                 e.title),
                  //       //                             Padding(
                  //       //                               padding:
                  //       //                               const EdgeInsets.all(8.0),
                  //       //                               child: Text.rich(
                  //       //                                   TextSpan(children: [
                  //       //                                     TextSpan(
                  //       //                                         style: const TextStyle(
                  //       //                                             color: Colors.blue),
                  //       //                                         text:
                  //       //                                         '${_selectedDay!.hour}: ${_selectedDay!.minute}: '),
                  //       //                                     TextSpan(
                  //       //                                       text: e.description,
                  //       //                                     ),
                  //       //                                   ])),
                  //       //                             )
                  //       //                           ])),
                  //       //                     ],
                  //       //                   ),
                  //       //                 ),
                  //       //                 const Icon(Icons.share)
                  //       //               ],
                  //       //             ),
                  //       //             Padding(
                  //       //               padding: const EdgeInsets.only(top: 10),
                  //       //               child: Row(
                  //       //                 mainAxisAlignment:
                  //       //                 MainAxisAlignment.center,
                  //       //                 children: [
                  //       //                   textBtn(context, 'Search ride', () {}),
                  //       //                   textBtn(context, 'Cancel Event', () {
                  //       //                     setState(() {
                  //       //                       _selectedEvents.value.clear();
                  //       //                       _getEventsForDay;
                  //       //                     });
                  //       //                   }),
                  //       //                 ],
                  //       //               ),
                  //       //             )
                  //       //           ],
                  //       //         ),
                  //       //       ))
                  //       //       .toList(),
                  //       // );
                  //
                  //       return ListView.builder(
                  //           physics: NeverScrollableScrollPhysics(),
                  //           primary: true,
                  //           itemCount: value.length,
                  //           shrinkWrap: true,
                  //           itemBuilder: (_, index) {
                  //             return Padding(
                  //               padding: const EdgeInsets.all(0.0),
                  //               child: Container(
                  //                 padding: EdgeInsets.symmetric(horizontal: 20),
                  //                 decoration: BoxDecoration(
                  //                     color: Colors.white),
                  //                 child: Column(
                  //                   children: [
                  //                     Row(
                  //                       children: [
                  //                         Container(
                  //                             width: 50,
                  //                             height: 50,
                  //                           alignment: Alignment.center,
                  //                           decoration: BoxDecoration(
                  //                             border: Border.all(
                  //                               width: 1,
                  //                               color: Colors.grey
                  //                             ),
                  //                             borderRadius: BorderRadius.circular(5)
                  //                           ),
                  //                           child: Column(
                  //                             mainAxisAlignment: MainAxisAlignment.center, // Memusatkan konten vertikal
                  //                             crossAxisAlignment: CrossAxisAlignment.center, // Memusatkan konten horizontal
                  //                             children: [
                  //                               Text(DateFormat('MMM').format(_focusedDay)),
                  //                               Text(DateFormat('d').format(_focusedDay))
                  //                             ],
                  //                           ),
                  //                         ),
                  //                         SizedBox(width: 15,),
                  //                         Expanded(
                  //                           child: Container(
                  //                             padding: EdgeInsets.symmetric(vertical: 20),
                  //                             decoration: BoxDecoration(
                  //                                 border: Border( bottom: BorderSide(
                  //                                   color: Colors.grey, // Warna border
                  //                                   width: index < value.length - 1 ? 1.0:0.0,         // Ketebalan border
                  //                                 ))
                  //                             ),
                  //                             child: Column(
                  //                               children: [
                  //                                 SizedBox(
                  //                                     child: Column(
                  //                                         crossAxisAlignment: CrossAxisAlignment.start,
                  //                                         children: [
                  //                                   Row(
                  //                                     children: [
                  //                                       Text(
                  //                                           maxLines: 1,
                  //                                           style:
                  //                                               const TextStyle(
                  //                                                   fontWeight:
                  //                                                       FontWeight
                  //                                                           .w500,
                  //                                                   fontSize: 16),
                  //                                           value[index].title),
                  //                                       Text(
                  //                                         maxLines: 2,
                  //                                         ' at ${_selectedDay!.hour}: ${_selectedDay!.minute}',
                  //                                         style: const TextStyle(
                  //                                             fontSize: 10),
                  //                                       )
                  //                                     ],
                  //                                   ),
                  //                                   Text('${DateFormat('dd, MMMM, yyyy').format(_focusedDay)} / ${DateHelper.convertToHijri(_focusedDay)}', style: TextStyle(fontSize: 12),)
                  //                                 ])),
                  //                               ],
                  //                             ),
                  //                           ),
                  //                         ),
                  //                       ],
                  //                     ),
                  //
                  //                   ],
                  //                 ),
                  //               ),
                  //             );
                  //           });
                  //     },
                  //     valueListenable: _selectedEvents,
                  //   ),
                  // )
                ],
              ),
            ),
          ),

          //  Vous pouvez également inclure des fonctionnalités telles que la modification ou l'annulation de réservations directement depuis cette liste
        ],
      ),
    );
  }

  void _navigateToPreviousMonth() {
    final newFocusedDay = DateTime(_currentMonth.year, _currentMonth.month - 1);
    setState(() {
      _focusedDay = newFocusedDay;
      _currentMonth = newFocusedDay;
    });
  }

  // Navigasi ke bulan berikutnya
  void _navigateToNextMonth() {
    final newFocusedDay = DateTime(_currentMonth.year, _currentMonth.month + 1);
    setState(() {
      _focusedDay = newFocusedDay;
      _currentMonth = newFocusedDay;
    });
  }

  Widget textBtn(BuildContext context, String text, VoidCallback voidCallback) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          voidCallback();
        },
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _focusedDay = focusedDay;
        _selectedDay = selectedDay;
      });
    }
  }

  void loadPreviousEvents() {
    events = {
      _selectedDay!: [const Event(title: '', description: '')],
      _selectedDay!: [const Event(title: '', description: '')]
    };
  }

//   _checkOnboardingCompleted() async {
// SharedPreferences prefs = await SharedPreferences.getInstance();
// return prefs.getStringList('key');
//}
}
