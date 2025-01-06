import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';

class Compass extends StatefulWidget {
  const Compass({super.key});

  @override
  State<Compass> createState() => _CompassState();
}

class _CompassState extends State<Compass> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController _animationController;
  double begin = 0.0;
  bool isFirstUpdate = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    animation = Tween(begin: 0.0, end: 0.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FlutterQiblah.qiblahStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return const Center(child: Text("Tidak dapat mendapatkan arah kiblat"));
          }

          final qiblahDirection = snapshot.data!;
          final deviceDirection = qiblahDirection.direction * (pi / 180) * -1; // Arah perangkat
          final qiblahAngle = qiblahDirection.qiblah * (pi / 180) * -1; // Arah kiblat

          if (isFirstUpdate) {
            begin = deviceDirection;
            animation = Tween(begin: begin, end: begin).animate(_animationController);
            isFirstUpdate = false;
          } else {
            _animationController.reset();
            animation = Tween(begin: begin, end: deviceDirection).animate(_animationController);
            begin = deviceDirection;
            _animationController.forward();
          }

          final qiblahDegrees = (qiblahDirection.offset + 360) % 360;

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Kompas: ${qiblahDirection.direction.toInt()}°",
                  style: const TextStyle(color: Colors.black, fontSize: 24),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 400,
                  width: 400,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Kompas utama yang berputar mengikuti arah perangkat
                      AnimatedBuilder(
                        animation: animation,
                        builder: (context, child) => Transform.rotate(
                          angle: animation.value,
                          child: Image.asset('assets/images/compass_dark.png',
                          ),
                        ),
                      ),
                      // Jarum penunjuk arah kiblat dari tengah
                      Transform.rotate(
                        angle: qiblahAngle,
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 350,
                            width: 350,
                            child: Image.asset('assets/images/arrow.png',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Arah Kiblat: ${qiblahDegrees.toStringAsFixed(2)}° dari utara',
                  style: const TextStyle(fontSize: 24),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
