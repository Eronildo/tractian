import 'package:flutter/material.dart';
import 'package:tractian/core/enums/asset_filter.dart';
import 'package:tractian/interactor/assets_controller.dart';
import 'package:tractian/core/components/button_widget.dart';

class FilterButtons extends StatelessWidget {
  const FilterButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = refAssetsController(context);

    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        final filter = controller.assetFilter;

        bool isEnergySelected = filter == AssetFilter.energy;
        bool isAlertSelected = filter == AssetFilter.alert;

        return Wrap(
          alignment: WrapAlignment.start,
          runSpacing: 10,
          children: [
            ButtonWidget(
              iconData: Icons.bolt_outlined,
              text: 'Sensor de Energia',
              filled: isEnergySelected,
              onPressed: () {
                if (isEnergySelected) {
                  controller.filterAssetsBy(filter: AssetFilter.none);
                  return;
                }
                controller.filterAssetsBy(filter: AssetFilter.energy);
              },
            ),
            const SizedBox(width: 10),
            ButtonWidget(
              iconData: Icons.error_outline,
              text: 'Crítico',
              filled: isAlertSelected,
              onPressed: () {
                if (isAlertSelected) {
                  controller.filterAssetsBy(filter: AssetFilter.none);
                  return;
                }
                controller.filterAssetsBy(filter: AssetFilter.alert);
              },
            ),
          ],
        );
      },
    );
  }
}
