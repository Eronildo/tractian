import 'package:flutter/material.dart';
import 'package:tractian/interactor/models/item.dart';
import 'package:tractian/ui/widgets/item_title_widget.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({super.key, required this.item, this.onTap});

  final Item item;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: ValueKey(item.id),
      contentPadding: EdgeInsets.zero,
      dense: true,
      minVerticalPadding: 0,
      minTileHeight: 0,
      horizontalTitleGap: 8,
      title: ItemTitleWidget(item: item, hasExpansor: onTap != null),
      onTap: onTap,
    );
  }
}
