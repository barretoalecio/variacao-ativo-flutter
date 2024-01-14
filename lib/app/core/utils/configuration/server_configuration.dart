import 'server_protocol.dart';

class ServerConfiguration {
  final String gatewayUrl = 'query2.finance.yahoo.com';

  final ServerProtocol protocol = ServerProtocol.https;

  @override
  String toString() {
    return '${protocol.asString()}://$gatewayUrl';
  }
}
