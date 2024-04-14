import 'package:code_hero/app/core/error/failures.dart';
import 'package:code_hero/app/data/datasources/character_datasource.dart';
import 'package:code_hero/app/data/models/get_characters_response.dart';
import 'package:code_hero/app/domain/repositories/character_repository.dart';
import 'package:code_hero/app/domain/usecases/get_characters.dart';
import 'package:dartz/dartz.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  /// Data Source
  final CharacterDatasource characterRemoteDatasource;

  const CharacterRepositoryImpl(this.characterRemoteDatasource);

  @override
  Future<Either<Failure, GetCharactersResponse>> getCharacters(
    GetCharactersParams params,
  ) async {
    final response = await characterRemoteDatasource.getCharacters(params);

    return response.fold(
      (failure) => Left(failure),
      (charactersResponse) => Right(charactersResponse),
    );
  }
}
