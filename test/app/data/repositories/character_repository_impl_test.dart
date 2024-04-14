import 'dart:convert';

import 'package:code_hero/app/core/di/injection_container.dart' as di;
import 'package:code_hero/app/core/error/failures.dart';
import 'package:code_hero/app/data/datasources/character_datasource.dart';
import 'package:code_hero/app/data/models/get_characters_response.dart';
import 'package:code_hero/app/data/repositories/character_repository_impl.dart';
import 'package:code_hero/app/domain/usecases/get_characters.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/fixture_reader.dart';
import 'character_repository_impl_test.mocks.dart';

@GenerateMocks([CharacterDatasource])
void main() {
  late MockCharacterDatasource mockCharacterDatasource;
  late CharacterRepositoryImpl charactersRepositoryImpl;

  setUp(() async {
    await di.init(isUnitTest: true);
    mockCharacterDatasource = MockCharacterDatasource();
    charactersRepositoryImpl = CharacterRepositoryImpl(
      mockCharacterDatasource,
    );
  });

  group("Get Characters", () {
    final getCharactersParams = GetCharactersParams(
      limit: 10,
      offset: 10,
      nameStartsWith: '',
    );

    final charactersResponse = const GetCharactersResponse().fromJson(
      json.decode(fixture('get_characters_response_success.json'))
          as Map<String, dynamic>,
    );

    test('should return a GetCharactersResponse when call data is successful',
        () async {
      // arrange

      when(mockCharacterDatasource.getCharacters(getCharactersParams))
          .thenAnswer(
        (_) async => Right(charactersResponse),
      );

      // act
      final result =
          await charactersRepositoryImpl.getCharacters(getCharactersParams);

      verify(mockCharacterDatasource.getCharacters(getCharactersParams));

      expect(result.isRight(), true);
    });

    test(
      'should return server failure when call data is unsuccessful',
      () async {
        // arrange
        when(mockCharacterDatasource.getCharacters(getCharactersParams))
            .thenAnswer(
          (_) async => const Left(
            ServerFailure(''),
          ),
        );

        // act
        final result =
            await charactersRepositoryImpl.getCharacters(getCharactersParams);

        // assert
        verify(mockCharacterDatasource.getCharacters(getCharactersParams));
        expect(result, const Left(ServerFailure('')));
      },
    );
  });
}
