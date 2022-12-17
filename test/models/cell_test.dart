import 'package:flutter_test/flutter_test.dart';
import 'package:minesweeper_flutter/models/cell.dart';

void main() {
  group(
    'Cell test',
    () {
      test(
        'Open cell WITH explosion',
        () {
          Cell c = Cell(row: 0, column: 0);
          c.mineCell();
          expect(c.open, throwsException);
        },
      );

      test(
        'Open cell WITHOUT explosion',
        () {
          Cell c = Cell(row: 0, column: 0);
          c.open();
          expect(c.opened, isTrue);
        },
      );

      test(
        'Add non neighbor',
        () {
          Cell c1 = Cell(row: 0, column: 0);
          Cell c2 = Cell(row: 1, column: 3);
          c1.addNeighbor(c2);
          expect(c1.neighbors.isEmpty, true);
        },
      );

      test(
        'Add valid neighbor',
        () {
          Cell c1 = Cell(row: 3, column: 3);
          Cell c2 = Cell(row: 3, column: 4);
          Cell c3 = Cell(row: 2, column: 2);
          Cell c4 = Cell(row: 4, column: 4);
          c1.addNeighbor(c2);
          c1.addNeighbor(c3);
          c1.addNeighbor(c4);
          expect(c1.neighbors.length, 3);
        },
      );

      test(
        'Mines in neighborhood',
        () {
          Cell c1 = Cell(row: 3, column: 3);
          Cell c2 = Cell(row: 3, column: 4);
          c2.mineCell();
          Cell c3 = Cell(row: 2, column: 2);
          Cell c4 = Cell(row: 4, column: 4);
          c4.mineCell();
          c1.addNeighbor(c2);
          c1.addNeighbor(c3);
          c1.addNeighbor(c4);
          expect(c1.quantityOfMinesInNeighborhood, 2);
        },
      );
    },
  );
}
