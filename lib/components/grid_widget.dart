import 'package:flutter/material.dart';
import 'package:minesweeper_flutter/components/cell_widget.dart';

import '../models/cell.dart';
import '../models/grid.dart';

class GridWidget extends StatelessWidget {
  final Grid grid;
  final void Function(Cell) onOpen;
  final void Function(Cell) onToggleMarked;

  const GridWidget({
    super.key,
    required this.grid,
    required this.onOpen,
    required this.onToggleMarked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: grid.columns,
        children: grid.cells
            .map((c) => CellWidget(
                  cell: c,
                  onOpen: onOpen,
                  onToggleMarked: onToggleMarked,
                ))
            .toList(),
      ),
    );
  }
}
