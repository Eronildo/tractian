import 'package:tractian/interactor/models/item.dart';

class Asset extends Item {
  Asset({
    required super.id,
    required super.name,
    required super.parentId,
    required super.depth,
    required this.gatewayId,
    required this.sensorId,
    required this.sensorType,
    required this.status,
  });

  final String? gatewayId;
  final String? sensorId;
  final String? sensorType;
  final String? status;

  bool get isComponent => sensorType != null || status != null;
  bool get isEnergy => sensorType == 'energy';
  bool get hasAlert => status == 'alert';

  factory Asset.fromMap(Map<String, dynamic> map) {
    return Asset(
      id: map['id'] as String,
      name: map['name'] as String,
      parentId: map['parentId'] != null
          ? map['parentId'] as String
          : map['locationId'] != null
              ? map['locationId'] as String
              : null,
      gatewayId: map['gatewayId'] != null ? map['gatewayId'] as String : null,
      sensorId: map['sensorId'] != null ? map['sensorId'] as String : null,
      sensorType:
          map['sensorType'] != null ? map['sensorType'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      depth: 0,
    );
  }
}
