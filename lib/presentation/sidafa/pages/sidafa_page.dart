import 'package:flutter/material.dart';

class SidafaPage extends StatefulWidget {
  const SidafaPage({super.key});

  @override
  State<SidafaPage> createState() => _SidafaPageState();
}

class _SidafaPageState extends State<SidafaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Setting"),
      ),
    );
  }
}
