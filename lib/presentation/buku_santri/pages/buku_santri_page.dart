import 'package:flutter/material.dart';

class BukuSantriPage extends StatefulWidget {
  const BukuSantriPage({super.key});

  @override
  State<BukuSantriPage> createState() => _BukuSantriPageState();
}

class _BukuSantriPageState extends State<BukuSantriPage> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text("Buku Santri"),
      ),
      body: Center(
        child: Text("Buku Santri"),
      ),
    );
  }
}
