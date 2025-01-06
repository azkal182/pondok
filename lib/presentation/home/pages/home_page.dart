import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pondok/core/widgets/menu_item.dart' as menu;
import 'package:pondok/core/widgets/poster_carousel.dart';
import 'package:pondok/presentation/home/blocs/prayer_times_bloc.dart';
import 'package:pondok/presentation/home/widgets/article_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime? nextPrayerTime;
  String? nextPrayerName;
  Duration remainingTime = Duration.zero;
  Timer? timer;
  Timer? timerCurrentTime;
  late String _currentTime;

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

    _currentTime = _formatCurrentTime();
    timerCurrentTime = Timer.periodic(const Duration(seconds: 1), (timer){
      if (mounted) {
        setState(() {
          _currentTime = _formatCurrentTime();
        });
      }
    });
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
    timerCurrentTime?.cancel();
    super.dispose();
  }

  final List<Map<String, dynamic>> menuItems = [
    {'icon': Icons.play_circle_fill, 'title': 'Dakwah', "path": "/dakwah"},
    {'icon': Icons.book, 'title': 'Buku Santri', "path": "/buku-santri"},
    {'icon': Icons.account_circle, 'title': 'Profile', "path": "/profile"},
    {'icon': Icons.store, 'title': 'Store', "path": "/store"},
    {'icon': Icons.calendar_today, 'title': 'Shalat', "path": "/sholat"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      padding: EdgeInsets.only(bottom: ScreenUtil().bottomBarHeight + 80),
      child: Column(
        children: [
          Container(
            height: 440.h,
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 8.h),
                  height: 440.h,
                  color: Colors.white,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.end, // Mendorong isi ke bawah
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Daftar Menu",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Aksi untuk tombol "Lihat Semua"
                                },
                                child: const Text(
                                  "Lihat Semua",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              for (int i = 0; i < 5; i++)
                                menu.MenuItem(
                                  path: menuItems[i]['path'],
                                  icon: menuItems[i]['icon'],
                                  title: menuItems[i]['title'],
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 0, // Atur posisi child secara absolut
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 250.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[Color(0xFF15527C), Color(0xFF13DCFF)],
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(60),
                        bottomRight: Radius.circular(60),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 70.h, // Atur posisi child secara absolut
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    'assets/images/monumen.png',
                    height: 275.h,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  top: 220.h,
                  left: 0,
                  right: 0,
                  child: BlocBuilder<PrayerTimesBloc, PrayerTimesState>(
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
                              'time':
                                  (todayPrayerTimes.first['time'] as DateTime)
                                      .add(Duration(days: 1)),
                            };
                          },
                        );

                        final nextTime = nextPrayer['time'] as DateTime;
                        final nextName = nextPrayer['name'] as String;

                        if (nextPrayerTime == null ||
                            nextPrayerTime != nextTime) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            startCountdown(nextTime, nextName);
                          });
                        }

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (_currentTime.isNotEmpty)
                              Text(
                                _currentTime,
                                style: GoogleFonts.roboto(
                                    fontSize: 40.sp,
                                    color: Color(0xFF363636),
                                    fontWeight: FontWeight.bold,
                                    height: 1),
                              ),
                            if (nextPrayerName != null && remainingTime.inSeconds > 0)
                              Text(
                                "$nextPrayerName ${_formatTime(nextPrayerTime!)} ( - ${_formatDuration(remainingTime)} )",
                                style: GoogleFonts.roboto(
                                    fontSize: 16.sp,
                                    color: Color(0xFF363636),
                                    fontWeight: FontWeight.w600),
                              ),
                                Text(
                                  "11 Desember 2024 / 02 Jumadul Awal 1446",
                                  style: GoogleFonts.roboto(
                                    fontSize: 12.sp,
                                    color: Color(0xFF363636),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  padding: const EdgeInsets.only(
                                      top: 2,
                                      bottom: 2,
                                      left: 10,
                                      right: 15), // Jarak antara konten dan tepi
                                  decoration: BoxDecoration(
                                    color: Color(0xFFD9D9D9), // Warna latar belakang
                                    borderRadius:
                                        BorderRadius.circular(16), // Sudut membulat
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize
                                        .min, // Agar Row hanya sesuai konten
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: Colors.red,
                                        size: 16.sp,
                                      ),
                                      SizedBox(width: 8), // Jarak antar elemen
                                      Text(
                                        "Bangsri, Kab Jepara",
                                        style: GoogleFonts.roboto(
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                )

                          ],
                        );
                      } else if (state is PrayerTimesError) {
                        return Center(child: Text('Error: ${state.message}'));
                      }
                      return const Center(child: Text('No Data'));
                    },
                  ),
                  // Column(
                  //   children: [
                  //     Text(
                  //       "03:45",
                  //       style: GoogleFonts.roboto(
                  //           fontSize: 40.sp,
                  //           color: Color(0xFF363636),
                  //           fontWeight: FontWeight.bold,
                  //           height: 1),
                  //     ),
                  //     Text(
                  //       "IMSAK 04:55 (-02:00:00)",
                  //       style: GoogleFonts.roboto(
                  //           fontSize: 16.sp,
                  //           color: Color(0xFF363636),
                  //           fontWeight: FontWeight.w600),
                  //     ),
                  //     Text(
                  //       "11 Desember 2024 / 02 Jumadul Awal 1446",
                  //       style: GoogleFonts.roboto(
                  //         fontSize: 12.sp,
                  //         color: Color(0xFF363636),
                  //       ),
                  //     ),
                  //     SizedBox(height: 5),
                  //     Container(
                  //       padding: const EdgeInsets.only(
                  //           top: 2,
                  //           bottom: 2,
                  //           left: 10,
                  //           right: 15), // Jarak antara konten dan tepi
                  //       decoration: BoxDecoration(
                  //         color: Color(0xFFD9D9D9), // Warna latar belakang
                  //         borderRadius:
                  //             BorderRadius.circular(16), // Sudut membulat
                  //       ),
                  //       child: Row(
                  //         mainAxisSize: MainAxisSize
                  //             .min, // Agar Row hanya sesuai konten
                  //         children: [
                  //           Icon(
                  //             Icons.location_on,
                  //             color: Colors.red,
                  //             size: 16.sp,
                  //           ),
                  //           SizedBox(width: 8), // Jarak antar elemen
                  //           Text(
                  //             "Bangsri, Kab Jepara",
                  //             style: GoogleFonts.roboto(
                  //               fontSize: 12.sp,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     )
                  //   ],
                  // )
                ),
                Positioned(
                    top: ScreenUtil().statusBarHeight,
                    left: 20,
                    right: 20,
                    child: Row(
                      children: [
                        Text(
                          'PP Darul Falah Amtsilati',
                          style: GoogleFonts.roboto(
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        ElevatedButton(
                            onPressed: () {
                              context.go('/qiblat');
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              backgroundColor: Colors.transparent,
                              elevation: 0, //
                            ),
                            child: Icon(
                              Icons.arrow_circle_up_outlined,
                              color: Colors.white,
                              size: 35,
                            ))
                      ],
                    )),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          PosterCarousel(),
          SizedBox(height: 10.h),
          ArticleList(),

          // Transform.translate(
          //   offset: Offset(0, -160.h),
          //   child: Image.asset(
          //     'assets/images/monumen.png',
          //     height: 250.h,
          //     fit: BoxFit.cover,
          //   ),
          // ),
          // // SizedBox(height: 100.h),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       const Text(
          //         "Daftar Menu",
          //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          //       ),
          //       GestureDetector(
          //         onTap: () {
          //           // Aksi untuk tombol "Lihat Semua"
          //         },
          //         child: const Text(
          //           "Lihat Semua",
          //           style: TextStyle(fontSize: 14, color: Colors.grey),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       for (int i = 0; i < 5; i++)
          //         menu.MenuItem(
          //           path: '/',
          //           icon: menuItems[i]['icon'],
          //           title: menuItems[i]['title'],
          //         ),
          //     ],
          //   ),
          // ),
        ],
      ),
    ));
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

String _formatCurrentTime() {
  final now = DateTime.now();
  return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
}

}
