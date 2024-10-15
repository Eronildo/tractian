import 'package:tractian/interactor/models/item.dart';

class Location extends Item {
  Location({
    required super.id,
    required super.name,
    required super.parentId,
    required super.depth,
  });

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      id: map['id'] as String,
      name: map['name'] as String,
      parentId: map['parentId'] != null ? map['parentId'] as String : null,
      depth: 0,
    );
  }
}
