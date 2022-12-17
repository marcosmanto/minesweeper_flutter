import 'dart:math';

import 'package:minesweeper_flutter/models/cell.dart';

class Grid {
  final int rows;
  final int columns;
  final int bombs;
  final List<Cell> _cells = [];

  Grid({
    required this.rows,
    required this.columns,
    required this.bombs,
  }) {
    _createCells();
    _boundNeighbors();
    _sortMines();
  }

  void restart() {
    for (var cell in _cells) {
      cell.restart();
    }
    _sortMines();
  }

  void revealBombs() {
    for (var cell in _cells) {
      cell.revealBomb();
    }
  }

  void _createCells() {
    for (int row = 0; row < rows; row++) {
      for (var column = 0; column < columns; column++) {
        _cells.add(Cell(row: row, column: column));
      }
    }
  }

  void _boundNeighbors() {
    for (Cell cell in _cells) {
      // if cell is neighbor it is added as neighbor, if not it is ignored.
      for (Cell neighbor in _cells) {
        cell.addNeighbor(neighbor);
      }
    }
  }

  void _sortMines() {
    int sorted = 0;
    if (bombs > rows * columns) {
      // ignore: avoid_print
      print('Quantity not allowed. It is higher than total cells.');
      return;
    }
    while (sorted < bombs) {
      int i = Random().nextInt(_cells.length);
      if (!_cells[i].mined) {
        sorted++;
        _cells[i].mineCell();
      }
    }
  }

  List<Cell> get cells {
    return _cells;
  }

  bool get resolved {
    // All cells resolved so the grid and the game is finished.
    return _cells.every((cell) => cell.resolved);
  }
}
