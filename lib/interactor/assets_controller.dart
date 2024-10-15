import 'package:flutter/widgets.dart';
import 'package:simple_ref/simple_ref.dart';

import 'package:tractian/core/debouncer/debouncer.dart';
import 'package:tractian/core/enums/asset_filter.dart';
import 'package:tractian/core/enums/status.dart';
import 'package:tractian/interactor/companies_controller.dart';
import 'package:tractian/interactor/extensions/item_list_extension.dart';
import 'package:tractian/interactor/models/item.dart';
import 'package:tractian/repository/tractian_repository.dart';

final refAssetsController = Ref.autoDispose(
  (_) => AssetsController(
    companyId: refSelectedCompanyId(),
    repository: refTractianRepository(),
  ),
);

class AssetsController with Disposable, ChangeNotifier {
  AssetsController({
    required String companyId,
    required TractianRepository repository,
  })  : _companyId = companyId,
        _repository = repository {
    searchTextEditingController
        .addListener(_searchTextEditingControllerListener);
    _initialize();
  }

  final String _companyId;
  final TractianRepository _repository;

  final _debouncer = Debouncer(milliseconds: 500);
  var _status = Status.loading;

  var _searchQuery = '';
  var _items = <Item>[];
  var _rawItems = <Item>[];
  var _assetFilter = AssetFilter.none;

  List<Item>? _filteredItems;

  final searchTextEditingController = TextEditingController();

  List<Item> get items => _items;
  Status get status => _status;
  String get searchQuery => _searchQuery;
  AssetFilter get assetFilter => _assetFilter;

  void _searchTextEditingControllerListener() {
    _debouncer.run(
      () {
        _searchQuery = searchTextEditingController.text;
        _filterItems();
      },
    );
  }

  Future<void> _initialize() async {
    try {
      final (locations, assets) = await (
        _repository.fetchLocationsBy(companyId: _companyId),
        _repository.fetchAssetsBy(companyId: _companyId),
      ).wait;

      _rawItems = [...locations, ...assets];
      _items = _rawItems.toSortedItems();
      _status = Status.success;
    } on Exception {
      _status = Status.error;
    } finally {
      notifyListeners();
    }
  }

  void _filterItems() {
    final query = _searchQuery.trim();

    final clearFilter = query.isEmpty && _assetFilter == AssetFilter.none;

    _items = _rawItems.toSortedItems(
      query: query,
      filter: _assetFilter,
    );

    _filteredItems = clearFilter ? null : _items;

    notifyListeners();
  }

  void reorderItems() {
    _items = (_filteredItems ?? _rawItems).toSortedItems();
    notifyListeners();
  }

  void filterAssetsBy({required AssetFilter filter}) {
    _assetFilter = filter;
    _filterItems();
  }

  @override
  void dispose() {
    super.dispose();
    _debouncer.dispose();
    searchTextEditingController
        .removeListener(_searchTextEditingControllerListener);
    searchTextEditingController.dispose();
  }
}
