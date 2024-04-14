import 'package:code_hero/app/core/api/dio_client.dart';
import 'package:code_hero/app/core/error/failures.dart';
import 'package:code_hero/app/data/datasources/character_datasource.dart';
import 'package:code_hero/app/data/models/get_characters_response.dart';
import 'package:code_hero/app/domain/usecases/get_characters.dart';
import 'package:dartz/dartz.dart';

class CharacterRemoteDatasourceImpl implements CharacterDatasource {
  final DioClient _client;

  CharacterRemoteDatasourceImpl(this._client);

  @override
  Future<Either<Failure, GetCharactersResponse>> getCharacters(
    GetCharactersParams params,
  ) async {
    final response = await _client.getRequest(
      '/v1/public/characters',
      queryParameters: {
        'limit': params.limit,
        'offset': params.offset,
        if (params.nameStartsWith?.isNotEmpty ?? false)
          'nameStartsWith': params.nameStartsWith,
      },
      //queryParameters: params.toJson(),
      converter: (response) => const GetCharactersResponse().fromJson(
        response['data'],
      ),
    );

    return response;
  }
}
