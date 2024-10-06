import 'package:signals/signals.dart';
import 'package:simple_ref/simple_ref.dart';
import 'package:tractian/repository/tractian_repository.dart';

// Reference for the Selected Company
final refSelectedCompanyId = Ref<String>(() => throw UnimplementedError());

final refCompaniesController = Ref.autoDispose(
  (_) => CompaniesController(
    repository: refTractianRepository(),
  ),
);

class CompaniesController with Disposable {
  CompaniesController({required TractianRepository repository})
      : _repository = repository;

  final TractianRepository _repository;

  late final signalCompaniesAsync =
      FutureSignal(() => _repository.fetchAllCompanies());

  void selectCompanyId(String companyId) =>
      refSelectedCompanyId.overrideWith(() => companyId);

  @override
  void dispose() {
    signalCompaniesAsync.dispose();
  }
}
