import 'package:minesweeper_flutter/models/explosion_exception.dart';

class Cell {
  final int row;
  final int column;
  final List<Cell> neighbors = [];
  bool _opened = false;
  bool _marked = false;
  bool _mined = false;
  bool _exploded = false;

  Cell({required this.row, required this.column});

  void addNeighbor(Cell neighbor) {
    final deltaRow = (row - neighbor.row).abs();
    final deltaColumn = (column - neighbor.column).abs();

    if (deltaRow == 0 && deltaColumn == 0) {
      return; // received itself as neighbor
    }

    if (deltaRow <= 1 && deltaColumn <= 1) {
      neighbors.add(neighbor);
    }
  }

  void open() {
    if (_opened) return;
    _opened = true;
    if (_mined) {
      _exploded = true;
      throw ExplosionException();
    }
    if (safeNeighborhood) {
      for (var neighbor in neighbors) {
        neighbor.open();
      }
    }
  }

  void revealBomb() {
    if (_mined) _opened = true;
  }

  void mineCell() {
    _mined = true;
  }

  void toogleMarked() {
    _marked = !_marked;
  }

  void restart() {
    _opened = false;
    _marked = false;
    _mined = false;
    _exploded = false;
  }

  bool get safeNeighborhood {
    return neighbors.every((neighbor) => !neighbor.mined);
  }

  int get quantityOfMinesInNeighborhood {
    return neighbors.where((neiighbor) => neiighbor.mined).length;
  }

  bool get resolved {
    bool minedAndMarked = mined && marked;
    bool secureAndOpened = !mined && opened;
    return minedAndMarked || secureAndOpened;
  }

  bool get mined {
    return _mined;
  }

  bool get exploded {
    return _exploded;
  }

  bool get opened {
    return _opened;
  }

  bool get marked {
    return _marked;
  }
}
