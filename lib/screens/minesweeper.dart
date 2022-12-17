// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:minesweeper_flutter/components/grid_widget.dart';
import 'package:minesweeper_flutter/components/result_widget.dart';
import 'package:minesweeper_flutter/models/cell.dart';
import 'package:minesweeper_flutter/models/explosion_exception.dart';
import 'package:minesweeper_flutter/models/grid.dart';

class Minesweeper extends StatefulWidget {
  const Minesweeper({super.key});

  @override
  State<Minesweeper> createState() => _MinesweeperState();
}

class _MinesweeperState extends State<Minesweeper> {
  bool? _win;
  final Grid _grid = Grid(rows: 12, columns: 12, bombs: 3);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: ResultWidget(win: _win, onRestarted: _restart),
        body: GridWidget(
          grid: _grid,
          onOpen: _open,
          onToggleMarked: _toggleMarked,
        ),
      ),
    );
  }

  void _open(Cell cell) {
    if (_win != null) return;
    setState(() {
      try {
        cell.open();
        if (_grid.resolved) {
          _win = true;
        }
      } on ExplosionException {
        _win = false;
        _grid.revealBombs();
      }
    });
    print('Opened cell [${cell.row},${cell.column}]');
  }

  void _toggleMarked(Cell cell) {
    if (_win != null) return;
    setState(() {
      cell.toggleMarked();
      if (_grid.resolved) {
        _win = true;
      }
    });
    print('Toggle marked state for cell [${cell.row},${cell.column}]');
  }

  void _restart() {
    print('Restarting...');
    setState(() {
      _win = null;
      _grid.restart();
    });
  }
}
