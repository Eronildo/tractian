import 'package:flutter/material.dart';
import 'package:tractian/core/extensions/string_extension.dart';
import 'package:tractian/interactor/assets_controller.dart';
import 'package:tractian/interactor/models/asset.dart';
import 'package:tractian/interactor/models/item.dart';
import 'package:tractian/ui/widgets/energy_and_or_alert_widget.dart';

class ItemTitleWidget extends StatelessWidget {
  const ItemTitleWidget({super.key, required this.item});

  final Item item;

  bool get _isAssetLeafEnergyOrHasAlert =>
      item.isLeaf &&
      item is Asset &&
      ((item as Asset).isEnergy || (item as Asset).hasAlert);

  @override
  Widget build(BuildContext context) {
    final searchQuery = refAssetsController(context).searchQuery.value.trim();
    final textStyle = DefaultTextStyle.of(context).style;

    return Row(
      children: [
        Flexible(
          child: Text.rich(
            TextSpan(
              children: searchQuery.isNotEmpty
                  ? item.name.getTextSpansWithHighlightedTexts(
                      searchQuery,
                      textStyle,
                    )
                  : [
                      TextSpan(
                        text: item.name,
                        style: textStyle,
                      ),
                    ],
            ),
          ),
        ),
        if (_isAssetLeafEnergyOrHasAlert)
          EnergyAndOrAlertWidget(asset: item as Asset),
      ],
    );
  }
}
