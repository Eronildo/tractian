// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tractian/core/enums/asset_filter.dart';
import 'package:tractian/interactor/models/asset.dart';
import 'package:tractian/interactor/models/item.dart';

extension ItemListX on List<Item> {
  List<Item> toSortedItems({
    String query = '',
    AssetFilter filter = AssetFilter.none,
  }) {
    Map<String?, List<Item>> itemMap = {};
    Set<String> matchingIds = {};
    final hasFilter = query.isNotEmpty || filter != AssetFilter.none;

    for (var item in this) {
      // Group items by parentId
      itemMap.putIfAbsent(item.parentId, () => []).add(item);

      var match = false;

      if (filter != AssetFilter.none && query.isNotEmpty) {
        match = (item is Asset &&
                (item.sensorType == filter.name ||
                    item.status == filter.name)) &&
            item.name.toLowerCase().contains(query.toLowerCase());
      } else if (query.isNotEmpty) {
        match = item.name.toLowerCase().contains(query.toLowerCase());
      } else {
        match = item is Asset &&
            (item.sensorType == filter.name || item.status == filter.name);
      }

      // If the item's contains the query and/or asset filter, add its id to matchingIds
      if (match) {
        matchingIds.add(item.id);

        // Add parents from item matched
        String? currentParentId = item.parentId;
        while (currentParentId != null) {
          matchingIds.add(currentParentId);
          currentParentId =
              firstWhere((i) => i.id == currentParentId, orElse: Item.empty)
                  .parentId;
        }
      }
    }

    List<Item> sortedList = [];
    _addItemsInHierarchy(
      SortItemDTO(
        sortedList: sortedList,
        itemMap: itemMap,
        parentId: null,
        depth: 0,
        hasFilter: hasFilter,
        matchingIds: matchingIds,
      ),
    );
    return sortedList;
  }

  void _addItemsInHierarchy(SortItemDTO dto) {
    if (dto.itemMap[dto.parentId] != null) {
      for (var item in dto.itemMap[dto.parentId]!) {
        if (dto.hasFilter) {
          if (dto.matchingIds.contains(item.id)) {
            _addItemChild(
              item: item,
              dto: dto,
            );
          }
        } else {
          _addItemChild(
            item: item,
            dto: dto,
          );
        }
      }
    }
  }

  _addItemChild({
    required Item item,
    required SortItemDTO dto,
  }) {
    // When filtering set all items to be expanded
    if (dto.hasFilter) item.isExpanded = true;

    // Set the depth of the current item
    item.depth = dto.depth;
    dto.sortedList.add(item);

    // If this item has children, set hasChild to true
    if (dto.itemMap.containsKey(item.id)) {
      item.hasChild = true;
    }

    // Only add children if the item is expanded
    if (item.isExpanded) {
      // Recursively add children of the current item
      _addItemsInHierarchy(
        dto.copyWith(
          parentId: item.id,
          depth: dto.depth + 1,
        ),
      );
    }
  }
}

class SortItemDTO {
  final List<Item> sortedList;
  final Map<String?, List<Item>> itemMap;
  final String? parentId;
  final int depth;
  final bool hasFilter;
  final Set<String> matchingIds;

  SortItemDTO({
    required this.sortedList,
    required this.itemMap,
    required this.parentId,
    required this.depth,
    required this.hasFilter,
    required this.matchingIds,
  });

  SortItemDTO copyWith({
    List<Item>? sortedList,
    Map<String?, List<Item>>? itemMap,
    String? parentId,
    int? depth,
    bool? hasFilter,
    Set<String>? matchingIds,
  }) {
    return SortItemDTO(
      sortedList: sortedList ?? this.sortedList,
      itemMap: itemMap ?? this.itemMap,
      parentId: parentId ?? this.parentId,
      depth: depth ?? this.depth,
      hasFilter: hasFilter ?? this.hasFilter,
      matchingIds: matchingIds ?? this.matchingIds,
    );
  }
}
