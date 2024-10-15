import 'package:flutter/material.dart';
import 'package:tractian/core/extensions/string_extension.dart';
import 'package:tractian/interactor/assets_controller.dart';
import 'package:tractian/interactor/models/asset.dart';
import 'package:tractian/interactor/models/item.dart';
import 'package:tractian/ui/widgets/asset_icon_widget.dart';
import 'package:tractian/ui/widgets/energy_and_or_alert_widget.dart';

class ItemTitleWidget extends StatelessWidget {
  const ItemTitleWidget(
      {super.key, required this.item, required this.hasExpansor});

  final Item item;
  final bool hasExpansor;

  bool get _isAssetEnergyOrHasAlert =>
      item is Asset && ((item as Asset).isEnergy || (item as Asset).hasAlert);

  @override
  Widget build(BuildContext context) {
    final searchQuery = refAssetsController(context).searchQuery.trim();
    final textStyle = DefaultTextStyle.of(context).style;

    return Row(
      children: [
        for (int i = 0; i < item.depth; i++)
          Container(
            margin: const EdgeInsets.only(left: 12),
            width: 1,
            height: 30,
            color: Colors.grey,
          ),
        if (hasExpansor)
          Icon(
            item.isExpanded
                ? Icons.keyboard_arrow_down_rounded
                : Icons.keyboard_arrow_right_rounded,
          )
        else
          const SizedBox(width: 12),
        AssetIconWidget(item: item),
        Flexible(
          child: Tooltip(
            message: item.name,
            child: Text.rich(
              style: const TextStyle(overflow: TextOverflow.ellipsis),
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
        ),
        if (_isAssetEnergyOrHasAlert)
          EnergyAndOrAlertWidget(asset: item as Asset),
      ],
    );
  }
}
