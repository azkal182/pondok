import 'package:flutter/material.dart';

class DakwahPage extends StatefulWidget {
  const DakwahPage({super.key});

  @override
  State<DakwahPage> createState() => _DakwahPageState();
}

class _DakwahPageState extends State<DakwahPage> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text("Dakwah"),
      ),
      body: Center(
        child: Text("Dakwah"),
      ),
    );
  }
}
