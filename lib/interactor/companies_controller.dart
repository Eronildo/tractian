import 'package:flutter/foundation.dart';
import 'package:simple_ref/simple_ref.dart';
import 'package:tractian/core/enums/status.dart';
import 'package:tractian/interactor/models/company.dart';
import 'package:tractian/repository/tractian_repository.dart';

// Reference for the Selected Company
final refSelectedCompanyId = Ref<String>(() => throw UnimplementedError());

final refCompaniesController = Ref.autoDispose(
  (_) => CompaniesController(
    repository: refTractianRepository(),
  ),
);

class CompaniesController with Disposable, ChangeNotifier {
  CompaniesController({required TractianRepository repository})
      : _repository = repository {
    _initialize();
  }

  final TractianRepository _repository;

  var _companies = <Company>[];
  var _status = Status.loading;

  Status get status => _status;
  List<Company> get companies => _companies;

  Future<void> _initialize() async {
    try {
      _companies = await _repository.fetchAllCompanies();
      _status = Status.success;
    } on Exception {
      _status = Status.error;
    } finally {
      notifyListeners();
    }
  }

  void selectCompanyId(String companyId) =>
      refSelectedCompanyId.overrideWith(() => companyId);
}
