import '../errors/coordinator_error_messages.dart';

class CoordinatorStateMessages {
  const CoordinatorStateMessages();

  static const gettingProperRouteToNavigate =
      'Obtendo a rota apropriada para navegar';
  static const successfullyGotProperRouteToNavigate =
      'Rota apropriada para navegar obtida com sucesso';
  static const unableToGetProperRouteToNavigate =
      CoordinatorErrorMessages.unableToGetProperRouteToNavigate;
}
