import 'package:rick_and_morty_universe/models/characters_model.dart';

abstract class CharactersRepository {
  Future<CharactersResponse> getCharacters();
  Future<CharactersResponse> getCharactersByPagination(int page);
}
