import 'package:tractian/core/enums/asset_filter.dart';
import 'package:tractian/interactor/models/asset.dart';
import 'package:tractian/interactor/models/item.dart';

typedef Filters = (AssetFilter filter, String query);

List<Item> mountOrganizedItems(List<Item> items) {
  final organizedItems = <Item>[];
  Map<String, List<Item>> parentToChildren = {};

  // To track added IDs
  Set<String> addedIds = {};

  for (var item in items) {
    // Add parents
    if (item.parentId == null && item.locationId == null) {
      organizedItems.add(item);
      addedIds.add(item.id);
    } else {
      // Group children with your parents
      parentToChildren
          .putIfAbsent(item.parentId ?? item.locationId ?? '', () => [])
          .add(item);
    }
  }

  // Invert children order
  Map<String, List<Item>> invertedMap = {
    for (var entry in parentToChildren.entries)
      entry.key: entry.value.reversed.toList()
  };

  while (invertedMap.isNotEmpty) {
    for (var item in items) {
      if (invertedMap.containsKey(item.id)) {
        var canRemoveParentToChildren = true;

        for (var child in invertedMap[item.id]!) {
          if (!addedIds.contains(child.id)) {
            final index =
                organizedItems.indexWhere((element) => element.id == item.id);
            if (index > -1) {
              child.depth = item.depth + 1;

              addedIds.add(child.id);
              child.parent = item;
              item.children.add(child);

              organizedItems.insert(index + 1, child);
            } else {
              canRemoveParentToChildren = false;
            }
          }
        }
        if (canRemoveParentToChildren) {
          invertedMap.remove(item.id);
        }
      }
    }
  }

  return organizedItems;
}

List<Item> filterItems({
  required List<Item> allItems,
  required Filters filters,
}) {
  final (filter, query) = filters;

  if (query.isNotEmpty || filter != AssetFilter.none) {
    Iterable<Item>? searchFilteredItems;

    // Filter all items by query
    if (query.isNotEmpty) {
      searchFilteredItems = allItems.where(
        (element) => element.name.toLowerCase().contains(
              query.toLowerCase(),
            ),
      );
    }

    // Filter assets by [AssetFilter]
    if (filter != AssetFilter.none) {
      searchFilteredItems = (searchFilteredItems ?? allItems).where(
        (element) =>
            element is Asset &&
            (element.sensorType == filter.name ||
                element.status == filter.name),
      );
    }

    if (searchFilteredItems == null) return allItems;

    List<Item> result = [];

    // Add parents of the filtered items
    for (final item in searchFilteredItems) {
      List<Item> hierarchy = [];
      Item? currentItem = item;

      currentItem.isFiltered = true;

      // Iteration with parents
      while (currentItem != null) {
        currentItem.isExpanded = true;
        hierarchy.add(currentItem);
        currentItem = currentItem.parent;
      }

      // Add parents in correct order (root parent to filtered item)
      result.addAll(hierarchy.reversed);
    }

    // Remove duplicates
    return result.toSet().toList();
  }

  return allItems.map((e) => e..isFiltered = false).toList();
}
