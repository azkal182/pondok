import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pondok/core/widgets/compass.dart';

class QiblaCompass extends StatefulWidget {
  const QiblaCompass({super.key});

  @override
  State<QiblaCompass> createState() => _QiblaCompassState();
}

class _QiblaCompassState extends State<QiblaCompass> {
  bool hasPermission = false;

  @override
  void initState() {
    super.initState();
    _checkPermission(); // Cek izin saat widget pertama kali dibangun
  }

  Future<void> _checkPermission() async {
    if (await Permission.location.serviceStatus.isEnabled) {
      var status = await Permission.location.status;
      if (status.isGranted) {
        setState(() {
          hasPermission = true;
        });
      } else {
        // Minta izin jika belum diberikan
        var result = await Permission.location.request();
        setState(() {
          hasPermission = (result == PermissionStatus.granted);
        });
      }
    } else {
      setState(() {
        hasPermission = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return hasPermission ? const Compass() : const Text("Permission failed");
  }
}
