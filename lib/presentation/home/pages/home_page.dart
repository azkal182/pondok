import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pondok/core/widgets/menu_item.dart' as menu;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> menuItems = [
    {'icon': Icons.play_circle_fill, 'title': 'Dakwah'},
    {'icon': Icons.book, 'title': 'Buku Santri'},
    {'icon': Icons.account_circle, 'title': 'Profile'},
    {'icon': Icons.store, 'title': 'Store'},
    {'icon': Icons.calendar_today, 'title': 'Shalat'},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60),
                ),
              ),
            ),
             SizedBox(height: 100.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Daftar Menu",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Aksi untuk tombol "Lihat Semua"
                    },
                    child: const Text(
                      "Lihat Semua",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
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
                      path: '/',
                      icon: menuItems[i]['icon'],
                      title: menuItems[i]['title'],
                    ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
