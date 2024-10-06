class Item {
  final String id;
  final String name;
  final String? parentId;
  final String? locationId;
  List<Item> children;
  Item? parent;
  int depth;
  bool isExpanded;
  bool isFiltered;

  Item({
    required this.id,
    required this.name,
    required this.parentId,
    this.locationId,
    this.parent,
    this.children = const [],
    this.depth = 0,
    this.isExpanded = true,
    this.isFiltered = false,
  });

  void _toExpandChildrenRecursively(bool isExpanded, Item item) {
    for (final child in item.children) {
      child.isExpanded = isExpanded;
      _toExpandChildrenRecursively(isExpanded, child);
    }
  }

  bool get isLeaf => children.isEmpty;
  bool get canExpand {
    var canExpand = !isLeaf;

    if (canExpand && isFiltered) {
      canExpand = children.where((element) => element.isFiltered).isNotEmpty;
    }

    return canExpand;
  }

  void toggleExpand() {
    isExpanded = !isExpanded;
    _toExpandChildrenRecursively(isExpanded, this);
  }

  @override
  bool operator ==(covariant Item other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.parentId == parentId &&
        other.locationId == locationId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        parentId.hashCode ^
        locationId.hashCode;
  }
}
