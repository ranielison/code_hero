import 'dart:convert';

import 'package:code_hero/app/core/api/dio_client.dart';
import 'package:code_hero/app/core/di/injection_container.dart' as di;
import 'package:code_hero/app/core/error/failures.dart';
import 'package:code_hero/app/data/datasources/character_remote_datasource_impl.dart';
import 'package:code_hero/app/data/models/get_characters_response.dart';
import 'package:code_hero/app/domain/usecases/get_characters.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  late CharacterRemoteDatasourceImpl dataSourceImpl;
  late DioAdapter dioAdapter;

  setUp(() async {
    await di.init(isUnitTest: true);
    dioAdapter = DioAdapter(dio: di.sl<DioClient>().dio);
    dataSourceImpl = CharacterRemoteDatasourceImpl(di.sl<DioClient>());
  });

  group('Get Characters', () {
    final getCharactersParams = GetCharactersParams(
      limit: 10,
      offset: 0,
      nameStartsWith: '',
    );

    final jsonResponse =
        json.decode(fixture('get_characters_response_success.json'))
            as Map<String, dynamic>;

    final getCharactersResponse = const GetCharactersResponse().fromJson(
      jsonResponse['data'],
    );

    test(
        'should return a GetCharacterResponse object if the status code is 200',
        () async {
      /// arrange
      final decode =
          json.decode(fixture('get_characters_response_success.json'));

      dioAdapter.onGet(
        '/v1/public/characters',
        queryParameters: getCharactersParams.toJson(),
        (server) => server.reply(
          200,
          decode,
        ),
      );

      /// act
      final result = await dataSourceImpl.getCharacters(getCharactersParams);

      /// assert
      result.fold(
        (l) => expect(l, null),
        (r) => expect(r, getCharactersResponse),
      );
    });

    test(
      'should return server faulure when response code is 400',
      () async {
        /// arrange
        dioAdapter.onPost(
          getCharactersParams.limit != null &&
                  getCharactersParams.offset != null
              ? '/v1/public/characters?limit=${getCharactersParams.limit}&offset=${getCharactersParams.offset}'
              : '/v1/public/characters',
          (server) => server.reply(
            400,
            {},
          ),
        );

        /// act
        final result = await dataSourceImpl.getCharacters(getCharactersParams);

        /// assert
        result.fold(
          (l) => expect(l, isA<ServerFailure>()),
          (r) => expect(r, null),
        );
      },
    );
  });
}
