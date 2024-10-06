import 'package:dio/dio.dart';
import 'package:simple_ref/simple_ref.dart';
import 'package:tractian/core/constants/app_constants.dart';
import 'package:tractian/interactor/models/asset.dart';
import 'package:tractian/interactor/models/company.dart';
import 'package:tractian/interactor/models/location.dart';

final refHttpClient = Ref(Dio.new);

final refTractianRepository =
    Ref(() => TractianRepository(httpClient: refHttpClient()));

class TractianRepository {
  TractianRepository({required Dio httpClient}) : _httpClient = httpClient;

  final Dio _httpClient;

  Future<List<Company>> fetchAllCompanies() async {
    final response = await _httpClient.getUri<List>(
      Uri.https(AppConstants.authority, AppConstants.companiesPath),
    );

    if (response.data case final data?) {
      return data.map((e) => Company.fromMap(e)).toList();
    }

    return [];
  }

  Future<List<Location>> fetchLocationsBy({required String companyId}) async {
    final response = await _httpClient.getUri<List>(
      Uri.https(AppConstants.authority, AppConstants.locationsPath(companyId)),
    );

    if (response.data case final data?) {
      return data.map((e) => Location.fromMap(e)).toList();
    }

    return [];
  }

  Future<List<Asset>> fetchAssetsBy({required String companyId}) async {
    final response = await _httpClient.getUri<List>(
      Uri.https(AppConstants.authority, AppConstants.assetsPath(companyId)),
    );

    if (response.data case final data?) {
      return data.map((e) => Asset.fromMap(e)).toList();
    }

    return [];
  }
}
