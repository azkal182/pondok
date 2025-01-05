import 'package:flutter/material.dart';

class QiblatPage extends StatefulWidget {
  const QiblatPage({super.key});

  @override
  State<QiblatPage> createState() => _QiblatPageState();
}

class _QiblatPageState extends State<QiblatPage> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text("Qiblat"),
      ),
      body: Center(
        child: Text("Qiblat"),
      ),
    );
  }
}
