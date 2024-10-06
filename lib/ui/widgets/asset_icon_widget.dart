import 'package:flutter/material.dart';
import 'package:tractian/core/icons/tractian_icons.dart';
import 'package:tractian/interactor/models/asset.dart';
import 'package:tractian/interactor/models/item.dart';
import 'package:tractian/interactor/models/location.dart';

class AssetIconWidget extends StatelessWidget {
  const AssetIconWidget({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Icon(
      size: 22,
      color: const Color(0xff2188ff),
      item is Location
          ? Icons.location_on_outlined
          : item is Asset
              ? (item as Asset).isComponent
                  ? Tractian.component
                  : Tractian.asset
              : Icons.square_outlined,
    );
  }
}
