import 'package:flutter/material.dart';

import '../models/cell.dart';

class CellWidget extends StatelessWidget {
  final Cell cell;
  final void Function(Cell) onOpen;
  final void Function(Cell) onToggleMarked;

  const CellWidget({
    super.key,
    required this.cell,
    required this.onOpen,
    required this.onToggleMarked,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onOpen(cell),
      onLongPress: () => onToggleMarked(cell),
      child: _getImage(),
    );
  }

  Widget _getImage() {
    if (cell.opened && cell.mined && cell.exploded) {
      return Image.asset('assets/images/bomba_0.jpeg');
    } else if (cell.opened && cell.mined) {
      return Image.asset('assets/images/bomba_1.jpeg');
    } else if (cell.opened) {
      return Image.asset(
          'assets/images/aberto_${cell.quantityOfMinesInNeighborhood}.jpeg');
    } else if (cell.marked) {
      return Image.asset('assets/images/bandeira.jpeg');
    } else {
      return Image.asset('assets/images/fechado.jpeg');
    }
  }
}
