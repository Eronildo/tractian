import 'package:flutter/material.dart';
import 'package:tractian/core/components/divider_widget.dart';
import 'package:tractian/core/components/state_widget.dart';
import 'package:tractian/core/components/loading_widget.dart';
import 'package:tractian/core/components/text_field_widget.dart';
import 'package:tractian/core/enums/status.dart';
import 'package:tractian/interactor/assets_controller.dart';
import 'package:tractian/ui/widgets/filter_buttons.dart';
import 'package:tractian/ui/widgets/item_widget.dart';

class AssetsPage extends StatelessWidget {
  const AssetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = refAssetsController(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Assets')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFieldWidget(
                  hintText: 'Buscar Ativo ou Local',
                  controller: controller.searchTextEditingController,
                ),
                const SizedBox(height: 10),
                const FilterButtons(),
              ],
            ),
          ),
          const DividerWidget(),
          Expanded(
            child: ListenableBuilder(
              listenable: controller,
              builder: (context, child) => switch (controller.status) {
                Status.loading => const LoadingWidget(),
                Status.error =>
                  const StateWidget.error(text: 'Erro ao tentar obter assets.'),
                Status.success => Builder(
                    builder: (context) {
                      final items = controller.items;

                      if (items.isEmpty) {
                        return const StateWidget.empty(
                          text: 'Nenhum asset encontrado '
                              '\npara os filtros aplicados.',
                        );
                      }
                      return ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return ItemWidget(
                            item: item,
                            onTap: item.hasChild
                                ? () {
                                    item.toggleExpander();
                                    controller.reorderItems();
                                  }
                                : null,
                          );
                        },
                      );
                    },
                  ),
              },
            ),
          ),
        ],
      ),
    );
  }
}
