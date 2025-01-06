// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:pondok/presentation/home/blocs/prayer_times_bloc.dart';
//
// class SholatPage extends StatefulWidget {
//   const SholatPage({super.key});
//
//   @override
//   State<SholatPage> createState() => _SholatPageState();
// }
//
// class _SholatPageState extends State<SholatPage> {
//   @override
//   void initState() {
//     super.initState();
//     // Automatically dispatch LoadPrayerTimes when the screen is opened
//     context.read<PrayerTimesBloc>().add(
//           LoadPrayerTimes(
//             date: DateTime.now(),
//             latitude: -6.5235,
//             longitude: 110.7633,
//             timezone: 7,
//           ),
//         );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Jadwal Sholat'),
//         backgroundColor: Theme.of(context).colorScheme.primary,
//         foregroundColor: Theme.of(context).colorScheme.onPrimary,
//       ),
//       body: BlocBuilder<PrayerTimesBloc, PrayerTimesState>(
//         builder: (context, state) {
//           if (state is PrayerTimesLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is PrayerTimesLoaded) {
//             return ListView.builder(
//               itemCount: state.prayerTimes.prayerTimes.length,
//               itemBuilder: (context, index) {
//                 final prayerTime = state.prayerTimes.prayerTimes[index];
//                 return ListTile(
//                   title: Text(prayerTime.name, style: GoogleFonts.roboto(
//                       fontSize: 16,
//                     fontWeight: FontWeight.w500
//                   )),
//                   trailing: Text(prayerTime.time, style: GoogleFonts.roboto(
//                     fontSize: 16
//                   ),),
//                 );
//               },
//             );
//           } else if (state is PrayerTimesError) {
//             return Center(child: Text('Error: ${state.message}'));
//           }
//           return const Center(child: Text('No Data'));
//         },
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pondok/presentation/pages/home/blocs/prayer_times_bloc.dart';

class SholatPage extends StatefulWidget {
  const SholatPage({super.key});

  @override
  State<SholatPage> createState() => _SholatPageState();
}

class _SholatPageState extends State<SholatPage> {
  DateTime? nextPrayerTime; // Waktu sholat berikutnya
  String? nextPrayerName; // Nama sholat berikutnya
  Duration remainingTime = Duration.zero; // Sisa waktu untuk countdown
  Timer? timer;

  @override
  void initState() {
    super.initState();
    // Dispatch event untuk memuat jadwal sholat
    context.read<PrayerTimesBloc>().add(
          LoadPrayerTimes(
            date: DateTime.now(),
            latitude: -6.5235,
            longitude: 110.7633,
            timezone: 7,
          ),
        );
  }

  // Memulai countdown
  void startCountdown(DateTime nextTime, String prayerName) {
    timer?.cancel(); // Hentikan timer sebelumnya jika ada
    nextPrayerTime = nextTime;
    nextPrayerName = prayerName;
    _updateRemainingTime();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _updateRemainingTime();
    });
  }

  // Memperbarui sisa waktu countdown
  void _updateRemainingTime() {
    setState(() {
      remainingTime = nextPrayerTime!.difference(DateTime.now());
      if (remainingTime.isNegative) {
        timer?.cancel(); // Hentikan timer jika waktu telah habis
        nextPrayerTime = null; // Reset waktu sholat berikutnya
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
        title: Text('Jadwal Sholat'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: BlocBuilder<PrayerTimesBloc, PrayerTimesState>(
        builder: (context, state) {
          if (state is PrayerTimesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PrayerTimesLoaded) {
            // Cari waktu sholat berikutnya
            final now = DateTime.now();
            final todayPrayerTimes = state.prayerTimes.prayerTimes
                .map((e) => {
                      'name': e.name,
                      'time': _parseTime(e.time),
                    })
                .toList();

            // Cek apakah waktu sekarang melewati semua waktu sholat hari ini
            final nextPrayer = todayPrayerTimes.firstWhere(
              (e) => (e['time'] as DateTime).isAfter(now),
              orElse: () {
                // Jika semua waktu sholat hari ini sudah lewat,
                // ambil waktu sholat pertama hari berikutnya
                return {
                  'name': todayPrayerTimes.first['name'] as String,
                  'time': (todayPrayerTimes.first['time'] as DateTime)
                      .add(Duration(days: 1)),
                };
              },
            );

            final nextTime = nextPrayer['time'] as DateTime;
            final nextName = nextPrayer['name'] as String;

            // Pastikan startCountdown dipanggil setelah build selesai
            if (nextPrayerTime == null || nextPrayerTime != nextTime) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                startCountdown(nextTime, nextName);
              });
            }

            return Column(
              children: [
                if (nextPrayerTime != null && nextPrayerName != null)
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: Text(
                      "Sholat Berikutnya: $nextPrayerName\n${_formatDuration(remainingTime)}",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.prayerTimes.prayerTimes.length,
                    itemBuilder: (context, index) {
                      final prayerTime = state.prayerTimes.prayerTimes[index];
                      return ListTile(
                        tileColor: prayerTime.name == nextName
                            ? Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.2)
                            : null,
                        title: Text(
                          prayerTime.name,
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: Text(
                          prayerTime.time,
                          style: GoogleFonts.roboto(fontSize: 16),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is PrayerTimesError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('No Data'));
        },
      ),
    );
  }

  // Fungsi untuk mem-parsing waktu dari string ke DateTime
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

  // Fungsi untuk memformat Duration ke format HH:MM:SS
  String _formatDuration(Duration duration) {
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }
}
