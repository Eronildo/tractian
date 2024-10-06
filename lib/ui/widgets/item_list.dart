import 'package:flutter/material.dart';
import 'package:tractian/interactor/models/item.dart';
import 'package:tractian/ui/widgets/item_widget.dart';

class ItemList extends StatefulWidget {
  const ItemList({
    super.key,
    required this.items,
  });

  final List<Item> items;

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  List<Item> get _filteredItems => widget.items
      .where((item) => item.depth == 0 || (item.parent?.isExpanded ?? true))
      .toList();

  @override
  Widget build(BuildContext context) {
    final filteredItems = _filteredItems;

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: filteredItems.length,
        (context, index) {
          final item = filteredItems[index];

          return ItemWidget(
            item: item,
            onTap: item.canExpand ? () => setState(item.toggleExpand) : null,
          );
        },
      ),
    );
  }
}
