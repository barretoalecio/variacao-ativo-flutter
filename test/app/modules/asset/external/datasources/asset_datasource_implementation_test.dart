import 'dart:convert';

import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:variacao_ativo/app/core/packages/network/http_client/http_client_implementation.dart';
import 'package:variacao_ativo/app/core/packages/network/http_client/http_response.dart';
import 'package:variacao_ativo/app/core/shared/infrastructure/exceptions/server_exception.dart';
import 'package:variacao_ativo/app/modules/asset/domain/parameters/asset_search_parameters.dart';
import 'package:variacao_ativo/app/modules/asset/external/datasources/asset_datasource_implementation.dart';
import 'package:variacao_ativo/app/modules/asset/infrastructure/exceptions/asset_not_found_exception.dart';

class MockHttpClient extends Mock implements HttpClientImplementation {}

void main() {
  group('AssetDataSourceImplementation', () {
    late AssetDataSourceImplementation dataSource;
    late MockHttpClient mockHttpClient;

    setUp(() {
      mockHttpClient = MockHttpClient();
      dataSource = AssetDataSourceImplementation(mockHttpClient);
    });

    test('should throw AssetNotFoundException on 404 status code', () async {
      const parameters = AssetSearchParameters(code: 'PETR4.SA');

      when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer(
        (_) async => HttpResponse(
          data: jsonEncode({'error': 'Not Found'}),
          statusCode: 404,
        ),
      );

      expect(
        () => dataSource.getAssetFloorDataByCode(parameters),
        throwsA(isA<AssetNotFoundException>()),
      );
      verify(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
          .called(1);
    });

    test('should throw ServerException on non-200 and non-404 status code',
        () async {
      const parameters = AssetSearchParameters(code: 'PETR4.SA');

      when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer(
        (_) async => HttpResponse(
          data: jsonEncode({'error': 'Internal Server Error'}),
          statusCode: 500,
        ),
      );

      expect(
        () => dataSource.getAssetFloorDataByCode(parameters),
        throwsA(isA<ServerException>()),
      );
      verify(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
          .called(1);
    });
  });
}
