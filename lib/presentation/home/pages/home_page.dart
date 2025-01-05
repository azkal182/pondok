import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pondok/core/widgets/menu_item.dart' as menu;
import 'package:pondok/core/widgets/poster_carousel.dart';
import 'package:pondok/presentation/home/widgets/article_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                    child: Column(
                      children: [
                        Text(
                          "03:45",
                          style: GoogleFonts.roboto(
                              fontSize: 40.sp,
                              color: Color(0xFF363636),
                              fontWeight: FontWeight.bold,
                              height: 1),
                        ),
                        Text(
                          "IMSAK 04:55 (-02:00:00)",
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
                    )),
                Positioned(
                    top: ScreenUtil().statusBarHeight + 5,
                    left: 20,
                    right: 20,
                    child: Row(
                      children: [
                        Text(
                          'PP Darul Falah Amtsilati',
                          style: GoogleFonts.roboto(
                              fontSize: 18.sp,
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        ElevatedButton(
                            onPressed: () {
                              context.go('/qiblat');
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(0),
                              backgroundColor: Colors
                                  .transparent, // Agar tampilan seperti Container
                              elevation: 0, //
                            ),
                            child: Icon(
                              Icons.arrow_circle_up_outlined,
                              color: Colors.white,
                              size: 30.sp,
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
}
