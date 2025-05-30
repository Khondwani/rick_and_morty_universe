import 'package:rick_and_morty_universe/models/character_model.dart';
import 'package:rick_and_morty_universe/models/info_model.dart';

class CharactersResponse {
  final Info info;
  final List<Character> results;

  CharactersResponse({required this.info, required this.results});

  factory CharactersResponse.fromJson(Map<String, dynamic> json) {
    return CharactersResponse(
      info: Info.fromJson(json['info']),
      results:
          (json['results'] as List)
              .map((item) => Character.fromJson(item))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'info': info.toJson(),
      'results': results.map((character) => character.toJson()).toList(),
    };
  }
}
