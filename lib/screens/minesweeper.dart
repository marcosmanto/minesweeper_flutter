import 'package:flutter/material.dart';
import 'package:minesweeper_flutter/components/result_widget.dart';

class Minesweeper extends StatelessWidget {
  const Minesweeper({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: ResultWidget(onRestarted: () {
          print('hello');
        }),
        body: const Center(
          child: Text('Grid'),
        ),
      ),
    );
  }
}
