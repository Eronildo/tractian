abstract class AppConstants {
  static const authority = 'fake-api.tractian.com';
  static const companiesPath = '/companies';
  static locationsPath(String companyId) =>
      '$companiesPath/$companyId/locations';
  static assetsPath(String companyId) => '$companiesPath/$companyId/assets';
  static const imageLogoPath = 'assets/images/logo.png';
}
