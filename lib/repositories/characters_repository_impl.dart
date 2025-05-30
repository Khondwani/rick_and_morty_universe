import 'package:rick_and_morty_universe/models/characters_model.dart';
import 'package:rick_and_morty_universe/repositories/characters_repository.dart';
import 'package:rick_and_morty_universe/services/characters/characters_service.dart';

class CharactersRepositoryImpl implements CharactersRepository {
  final CharactersService _charactersService;

  CharactersRepositoryImpl(this._charactersService);

  @override
  Future<CharactersResponse> getCharacters() async {
    try {
      return await _charactersService.fetchCharacters();
    } catch (e) {
      throw Exception('Failed to load characters: ${e.toString()}');
    }
  }

  @override
  Future<CharactersResponse> getCharactersByPagination(int page) {
    try {
      return _charactersService.fetchCharactersByPagination(page);
    } catch (e) {
      throw Exception(
        'Failed to load characters by pagination: ${e.toString()}',
      );
    }
  }
}
