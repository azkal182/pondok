import "package:go_router/go_router.dart";
import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String path;

  const MenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.path
  });

  @override
  Widget build(BuildContext context) {
    print(icon);
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min, // Memastikan tinggi menyesuaikan konten
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 0),
                backgroundColor: Colors.transparent, // Agar tampilan seperti Container
                elevation: 0, // Menghilangkan bayangan
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                context.go(path);
              },
              child: AspectRatio(
                aspectRatio: 1, // Pastikan kotak persegi
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Color(0xff15527C).withOpacity(0.4),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    size: 35,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),

          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 9.0), // Padding hanya pada AspectRatio
          //   child: AspectRatio(
          //     aspectRatio: 1, // Pastikan kotak persegi
          //     child: Container(
          //       decoration: BoxDecoration(
          //         color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          //         borderRadius: BorderRadius.circular(8),
          //       ),
          //       child: Icon(
          //         icon,
          //         size: 35,
          //         color: Theme.of(context).colorScheme.primary,
          //       ),
          //     ),
          //   ),
          // ),
          // const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.1,
              color: Theme.of(context).colorScheme.onSurface,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}
