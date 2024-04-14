import 'package:code_hero/app/core/error/failures.dart';
import 'package:code_hero/app/data/models/get_characters_response.dart';
import 'package:code_hero/app/domain/usecases/get_characters.dart';
import 'package:dartz/dartz.dart';

abstract class CharacterDatasource {
  Future<Either<Failure, GetCharactersResponse>> getCharacters(
    GetCharactersParams params,
  );
}
