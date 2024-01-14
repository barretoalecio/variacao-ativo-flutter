import '../configuration/server_configuration.dart';

class APIRoutes {

  static String postActions() {
    return '${ServerConfiguration().toString()}';
  }

}
