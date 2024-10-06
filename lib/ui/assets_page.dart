import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';
import 'package:tractian/core/components/state_widget.dart';
import 'package:tractian/core/components/loading_widget.dart';
import 'package:tractian/interactor/assets_controller.dart';
import 'package:tractian/ui/widgets/assets_filter_delegate.dart';
import 'package:tractian/ui/widgets/item_list.dart';

class AssetsPage extends StatelessWidget {
  const AssetsPage({super.key});

  Widget _getSliverErrorWidget(String message) =>
      SliverFillRemaining(child: StateWidget.empty(text: message));

  @override
  Widget build(BuildContext context) {
    final assetsController = refAssetsController(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Assets')),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: AssetsFilterDelegate(),
          ),
          Watch(
            (context) => assetsController.loadItems.value.map(
              data: (_) {
                final items = assetsController.filteredItems.value;

                if (items.isEmpty) {
                  return _getSliverErrorWidget(
                    'Nenhum asset encontrado '
                    '\npara os filtros aplicados.',
                  );
                }
                return ItemList(items: items);
              },
              error: () =>
                  _getSliverErrorWidget('Erro ao tentar obter assets.'),
              loading: () => const SliverFillRemaining(child: LoadingWidget()),
            ),
          ),
        ],
      ),
    );
  }
}
