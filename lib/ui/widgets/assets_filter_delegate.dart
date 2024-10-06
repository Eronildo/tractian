import 'package:flutter/material.dart';
import 'package:tractian/core/components/divider_widget.dart';
import 'package:tractian/core/components/text_field_widget.dart';
import 'package:tractian/interactor/assets_controller.dart';
import 'package:tractian/ui/widgets/filter_buttons.dart';

const _assetsFilterHeaderHeight = 140.0;

class AssetsFilterDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final assetsController = refAssetsController(context);

    return ColoredBox(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 15,
            ),
            child: Column(
              children: [
                TextFieldWidget(
                  hintText: 'Buscar Ativo ou Local',
                  controller: assetsController.searchTextEditingController,
                ),
                const SizedBox(height: 10),
                const FilterButtons(),
              ],
            ),
          ),
          const DividerWidget(),
        ],
      ),
    );
  }

  @override
  double get maxExtent => _assetsFilterHeaderHeight;

  @override
  double get minExtent => _assetsFilterHeaderHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
