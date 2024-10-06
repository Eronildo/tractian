import 'package:flutter/material.dart';
import 'package:tractian/interactor/models/item.dart';
import 'package:tractian/ui/widgets/asset_icon_widget.dart';
import 'package:tractian/ui/widgets/item_title_widget.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({super.key, required this.item, this.onTap});

  final Item item;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: ValueKey(item.id),
      minTileHeight: 38,
      horizontalTitleGap: 8,
      title: ItemTitleWidget(item: item),
      onTap: onTap,
      leading: onTap == null
          ? Padding(
              padding: const EdgeInsets.only(right: 3, left: 26),
              child: AssetIconWidget(item: item),
            )
          : SizedBox(
              width: 48,
              child: Padding(
                padding: const EdgeInsets.only(left: 2),
                child: Row(
                  children: [
                    Icon(
                      item.isExpanded
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard_arrow_right,
                    ),
                    AssetIconWidget(item: item),
                  ],
                ),
              ),
            ),
      contentPadding: EdgeInsets.only(left: item.depth * 16.0),
    );
  }
}
