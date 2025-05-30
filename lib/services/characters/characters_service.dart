import 'package:rick_and_morty_universe/models/characters_model.dart';
import 'package:rick_and_morty_universe/services/api_manager/api_manager_service.dart';

class CharactersService {
  final APIManagerService _apiManagerService;
  CharactersService(this._apiManagerService);

  Future<CharactersResponse> fetchCharacters() async {
    final response = await _apiManagerService.get('character');
    if (response.statusCode == 200) {
      return CharactersResponse.fromJson(response.data);
    } else {
      throw Exception('Failed to load characters');
    }
  }

  Future<CharactersResponse> fetchCharactersByPagination(int page) async {
    final response = await _apiManagerService.get('character?page=$page');
    if (response.statusCode == 200) {
      return CharactersResponse.fromJson(response.data);
    } else {
      throw Exception('Failed to load characters');
    }
  }
}
