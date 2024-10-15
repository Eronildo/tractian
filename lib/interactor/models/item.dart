class Item {
  final String id;
  final String name;
  final String? parentId;
  bool isExpanded;
  int depth;
  bool hasChild;

  Item({
    required this.id,
    required this.name,
    required this.parentId,
    this.depth = 0,
    this.isExpanded = true,
    this.hasChild = false,
  });

  factory Item.empty() => Item(id: '', name: '', parentId: null);

  void toggleExpander() {
    isExpanded = !isExpanded;
  }
}
