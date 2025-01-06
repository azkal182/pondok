import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pondok/core/widgets/compass.dart';

class QiblatPage extends StatefulWidget {
  const QiblatPage({super.key});

  @override
  State<QiblatPage> createState() => _QiblatPageState();
}

class _QiblatPageState extends State<QiblatPage> {
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
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text("Qiblat"),
        ),
        body:
            hasPermission ? const Compass() : const Text("Permission failed"));
  }
}
