import 'dart:isolate';

import 'package:flutter/widgets.dart';
import 'package:signals/signals.dart';
import 'package:simple_ref/simple_ref.dart';

import 'package:tractian/core/debouncer/debouncer.dart';
import 'package:tractian/core/enums/asset_filter.dart';
import 'package:tractian/interactor/adapters/items_adapter.dart';
import 'package:tractian/interactor/companies_controller.dart';
import 'package:tractian/interactor/models/item.dart';
import 'package:tractian/repository/tractian_repository.dart';

final refAssetsController = Ref.autoDispose(
  (_) => AssetsController(
    companyId: refSelectedCompanyId(),
    repository: refTractianRepository(),
  ),
);

class AssetsController with Disposable {
  AssetsController({
    required String companyId,
    required TractianRepository repository,
  })  : _companyId = companyId,
        _repository = repository {
    searchTextEditingController
        .addListener(_searchTextEditingControllerListener);
  }

  final String _companyId;
  final TractianRepository _repository;

  final _debouncer = Debouncer(milliseconds: 500);
  final _searchQuery = ''.asSignal();
  final _assetFilter = AssetFilter.none.asSignal();

  final searchTextEditingController = TextEditingController();

  ReadonlySignal<String> get searchQuery => _searchQuery;
  ReadonlySignal<AssetFilter> get assetFilter => _assetFilter;

  late final loadItems = FutureSignal(_getAllItems);
  late final filteredItems = computed<List<Item>>(_getFilteredItems);

  void _searchTextEditingControllerListener() {
    _debouncer.run(
      () => _searchQuery.value = searchTextEditingController.text,
    );
  }

  Future<List<Item>> _getAllItems() async {
    final (locations, assets) = await (
      _repository.fetchLocationsBy(companyId: _companyId),
      _repository.fetchAssetsBy(companyId: _companyId),
    ).wait;

    final allItems = [...locations, ...assets];

    return Isolate.run(() => mountOrganizedItems(allItems));
  }

  List<Item> _getFilteredItems() {
    final asyncItems = loadItems.value;

    if (asyncItems.value case final loadedItems?) {
      final filter = _assetFilter.value;
      final query = _searchQuery.value.trim();

      return filterItems(
        allItems: loadedItems,
        filters: (filter, query),
      );
    }

    return [];
  }

  void filterAssetsBy({required AssetFilter filter}) =>
      _assetFilter.value = filter;

  @override
  void dispose() {
    _assetFilter.dispose();
    _searchQuery.dispose();
    _debouncer.dispose();
    filteredItems.dispose();
    searchTextEditingController
        .removeListener(_searchTextEditingControllerListener);
    searchTextEditingController.dispose();
  }
}
