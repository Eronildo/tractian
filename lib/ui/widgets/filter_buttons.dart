import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';
import 'package:tractian/core/enums/asset_filter.dart';
import 'package:tractian/interactor/assets_controller.dart';
import 'package:tractian/core/components/button_widget.dart';

class FilterButtons extends StatelessWidget {
  const FilterButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final assetsController = refAssetsController(context);

    return Watch(
      (context) {
        final filter = assetsController.assetFilter.value;

        bool isEnergySelected = filter == AssetFilter.energy;
        bool isAlertSelected = filter == AssetFilter.alert;

        return Align(
          alignment: Alignment.centerLeft,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ButtonWidget(
                  iconData: Icons.bolt_outlined,
                  text: 'Sensor de Energia',
                  filled: isEnergySelected,
                  onPressed: () {
                    if (isEnergySelected) {
                      assetsController.filterAssetsBy(filter: AssetFilter.none);
                      return;
                    }
                    assetsController.filterAssetsBy(filter: AssetFilter.energy);
                  },
                ),
                const SizedBox(width: 10),
                ButtonWidget(
                  iconData: Icons.error_outline,
                  text: 'Crítico',
                  filled: isAlertSelected,
                  onPressed: () {
                    if (isAlertSelected) {
                      assetsController.filterAssetsBy(filter: AssetFilter.none);
                      return;
                    }
                    assetsController.filterAssetsBy(filter: AssetFilter.alert);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
