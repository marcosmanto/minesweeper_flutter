// ignore_for_file: avoid_print

import 'dart:math';

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
  Grid? _grid;

  @override
  void initState() {
    super.initState();
  }

  int randBetween(int min, int max) => min + Random().nextInt((max + 1) - min);

  int randomNumberOfBombs(int rows, int columns) {
    int total = columns * rows;
    int max = (0.2 * total).floor();
    int min = (0.1 * total).floor();
    return randBetween(min, max);
  }

  Grid _getGrid(double width, double height) {
    if (_grid == null) {
      int qtyColumns = 15;
      double sizeOfCell = width / qtyColumns;
      int qtyRows = (height / sizeOfCell).floor();

      _grid = Grid(
        rows: qtyRows,
        columns: qtyColumns,
        bombs: randomNumberOfBombs(qtyRows, qtyColumns),
      );
    }
    return _grid!;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: ResultWidget(win: _win, onRestarted: _restart),
        body: Container(
          color: Colors.grey,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return GridWidget(
                grid: _getGrid(
                  constraints.maxWidth,
                  constraints.maxHeight,
                ),
                onOpen: _open,
                onToggleMarked: _toggleMarked,
              );
            },
          ),
        ),
      ),
    );
  }

  void _open(Cell cell) {
    if (_win != null || _grid == null) return;
    setState(() {
      try {
        cell.open();
        if (_grid!.resolved) {
          _win = true;
        }
      } on ExplosionException {
        _win = false;
        _grid!.revealBombs();
      }
    });
    print('Opened cell [${cell.row},${cell.column}]');
  }

  void _toggleMarked(Cell cell) {
    if (_win != null || _grid == null) return;
    setState(() {
      cell.toggleMarked();
      if (_grid!.resolved) {
        _win = true;
      }
    });
    print('Toggle marked state for cell [${cell.row},${cell.column}]');
  }

  void _restart() {
    if (_grid == null) return;
    print('Restarting...');
    setState(() {
      _win = null;
      _grid!.restart();
    });
  }
}
