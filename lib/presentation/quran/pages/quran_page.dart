import 'package:flutter/material.dart';

class QuranPage extends StatefulWidget {
  const QuranPage({super.key});

  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text("Al-Qur'an", style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary
        ),),
      ),
      body: Center(
        child: Text("Qur'an"),
      ),
    );
  }
}
