import '../configuration/server_configuration.dart';

class APIRoutes {
  static const String API_VERSION = 'v8';

  static const String FINANCE_SERVICE = 'finance';
  static const String CHART_SERVICE = 'chart';

  static const String INTERVAL = '1d';
  static const String RANGE = '30d';

  static String getLast30AssetFlorDataByName(String assetCode) {
    return '${ServerConfiguration().toString()}/$API_VERSION/$FINANCE_SERVICE/$CHART_SERVICE/$assetCode?interval=$INTERVAL&range=$RANGE';
  }
}
