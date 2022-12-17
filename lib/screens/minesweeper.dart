import 'package:flutter/material.dart';

class Minesweeper extends StatelessWidget {
  const Minesweeper({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Minesweeper'),
        ),
        body: const Center(
          child: Text('Grid'),
        ),
      ),
    );
  }
}
