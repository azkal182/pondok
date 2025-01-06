import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pondok/presentation/pages/home/blocs/prayer_times_bloc.dart';

class NextPrayerPage extends StatefulWidget {
  const NextPrayerPage({super.key});

  @override
  State<NextPrayerPage> createState() => _NextPrayerPageState();
}

class _NextPrayerPageState extends State<NextPrayerPage> {
  DateTime? nextPrayerTime;
  String? nextPrayerName;
  Duration remainingTime = Duration.zero;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    context.read<PrayerTimesBloc>().add(
          LoadPrayerTimes(
            date: DateTime.now(),
            latitude: -6.5235,
            longitude: 110.7633,
            timezone: 7,
          ),
        );
  }

  void startCountdown(DateTime nextTime, String prayerName) {
    timer?.cancel();
    nextPrayerTime = nextTime;
    nextPrayerName = prayerName;
    _updateRemainingTime();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _updateRemainingTime();
    });
  }

  void _updateRemainingTime() {
    setState(() {
      remainingTime = nextPrayerTime!.difference(DateTime.now());
      if (remainingTime.isNegative) {
        timer?.cancel();
        nextPrayerTime = null;
        nextPrayerName = null;
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Waktu Sholat Berikutnya'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: BlocBuilder<PrayerTimesBloc, PrayerTimesState>(
        builder: (context, state) {
          if (state is PrayerTimesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PrayerTimesLoaded) {
            final now = DateTime.now();
            final todayPrayerTimes = state.prayerTimes.prayerTimes
                .map((e) => {
                      'name': e.name,
                      'time': _parseTime(e.time),
                    })
                .toList();

            final nextPrayer = todayPrayerTimes.firstWhere(
              (e) => (e['time'] as DateTime).isAfter(now),
              orElse: () {
                return {
                  'name': todayPrayerTimes.first['name'] as String,
                  'time': (todayPrayerTimes.first['time'] as DateTime)
                      .add(Duration(days: 1)),
                };
              },
            );

            final nextTime = nextPrayer['time'] as DateTime;
            final nextName = nextPrayer['name'] as String;

            if (nextPrayerTime == null || nextPrayerTime != nextTime) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                startCountdown(nextTime, nextName);
              });
            }

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (nextPrayerName != null)
                    Text(
                      "Sholat Berikutnya: $nextPrayerName",
                      style: GoogleFonts.roboto(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  if (nextPrayerTime != null)
                    Text(
                      "${_formatTime(nextPrayerTime!)}",
                      style: GoogleFonts.roboto(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  if (remainingTime.inSeconds > 0)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        _formatDuration(remainingTime),
                        style: GoogleFonts.roboto(
                          fontSize: 32,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                ],
              ),
            );
          } else if (state is PrayerTimesError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('No Data'));
        },
      ),
    );
  }

  DateTime _parseTime(String time) {
    final now = DateTime.now();
    final parts = time.split(":");
    return DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(parts[0]),
      int.parse(parts[1]),
    );
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }

  String _formatTime(DateTime time) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }
}
