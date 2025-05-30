import 'package:rick_and_morty_universe/models/character_model.dart';

abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

class CharactersLoading extends CharactersState {}

class CharactersLoadingMore extends CharactersState {
  final List<Character> currentCharacters;

  CharactersLoadingMore(this.currentCharacters);
}

class CharactersLoaded extends CharactersState {
  final List<Character> characters;
  final bool hasReachedMax;
  final int currentPage;
  final int totalPages;

  CharactersLoaded({
    required this.characters,
    required this.hasReachedMax,
    required this.currentPage,
    required this.totalPages,
  });

  CharactersLoaded copyWith({
    List<Character>? characters,
    bool? hasReachedMax,
    int? currentPage,
    int? totalPages,
  }) {
    return CharactersLoaded(
      characters: characters ?? this.characters,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
    );
  }
}

class CharactersError extends CharactersState {
  final String message;

  CharactersError(this.message);
}
