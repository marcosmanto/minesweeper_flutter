// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:minesweeper_flutter/components/cell_widget.dart';
import 'package:minesweeper_flutter/components/grid_widget.dart';
import 'package:minesweeper_flutter/components/result_widget.dart';
import 'package:minesweeper_flutter/models/cell.dart';
import 'package:minesweeper_flutter/models/explosion_exception.dart';
import 'package:minesweeper_flutter/models/grid.dart';

class Minesweeper extends StatelessWidget {
  const Minesweeper({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: ResultWidget(onRestarted: _restart),
        body: GridWidget(
            grid: Grid(
              rows: 15,
              columns: 15,
              bombs: 10,
            ),
            onOpen: _open,
            onToggleMarked: _toggleMarked),
      ),
    );
  }

  void _open(Cell cell) {
    print('Opened cell [${cell.row},${cell.column}]');
  }

  void _toggleMarked(Cell cell) {
    print('Toggle marked state for cell [${cell.row},${cell.column}]');
  }

  void _restart() {
    print('Restarting...');
  }
}
