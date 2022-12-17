import 'package:flutter_test/flutter_test.dart';
import 'package:minesweeper_flutter/models/grid.dart';

void main() {
  group(
    'Grid test',
    () {
      test(
        'Win the game',
        () {
          Grid grid = Grid(
            rows: 2,
            columns: 2,
            bombs: 0,
          );

          grid.cells[0].mineCell();
          grid.cells[3].mineCell();

          grid.cells[0].toggleMarked();
          grid.cells[1].open();
          grid.cells[2].open();
          grid.cells[3].toggleMarked();

          expect(grid.resolved, isTrue);
        },
      );
    },
  );
}
