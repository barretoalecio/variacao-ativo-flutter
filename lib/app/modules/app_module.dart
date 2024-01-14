import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;

import '../core/packages/network/http_client/http_client_implementation.dart';
import '../core/packages/network/network_status/network_status.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.add(http.Client.new);
    i.add<http.Client>(HttpClientImplementation.new);
    i.add(Connectivity.new);
    i.add(NetworkServiceImplementation.new);
  }
 }
