import 'package:flutter/material.dart';
import 'package:minesweeper_flutter/components/cell_widget.dart';
import 'package:minesweeper_flutter/components/result_widget.dart';
import 'package:minesweeper_flutter/models/cell.dart';
import 'package:minesweeper_flutter/models/explosion_exception.dart';

class Minesweeper extends StatelessWidget {
  const Minesweeper({super.key});

  @override
  Widget build(BuildContext context) {
    Cell cell = Cell(row: 0, column: 0);
    Cell neighbor1 = Cell(row: 1, column: 0);
    neighbor1.mineCell();
    Cell neighbor2 = Cell(row: 1, column: 1);
    neighbor2.mineCell();
    cell.addNeighbor(neighbor1);
    cell.addNeighbor(neighbor2);
    try {
      //cell.mineCell();
      cell.toggleMarked();
      //cell.open();
    } on ExplosionException {
      // do nothing
    }
    return MaterialApp(
      home: Scaffold(
        appBar: ResultWidget(onRestarted: _restart),
        body: Center(
          child: CellWidget(
            cell: cell,
            onOpen: _open,
            onToggleMarked: _toggleMarked,
          ),
        ),
      ),
    );
  }

  void _open(Cell cell) {}

  void _toggleMarked(Cell cell) {}

  void _restart() {}
}
