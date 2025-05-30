import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_universe/repositories/characters_repository.dart';
import 'package:rick_and_morty_universe/state/bloc/characters_events.dart';
import 'package:rick_and_morty_universe/state/bloc/characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final CharactersRepository _repository;

  CharactersBloc(this._repository) : super(CharactersInitial()) {
    on<LoadCharacters>(_onLoadCharacters);
    on<LoadMoreCharacters>(_onLoadMoreCharacters);
  }

  Future<void> _onLoadCharacters(
    LoadCharacters event,
    Emitter<CharactersState> emit,
  ) async {
    if (event.isRefresh && state is CharactersLoaded) {
      // Don't show loading for refresh
    } else {
      emit(CharactersLoading());
    }

    try {
      final response = await _repository.getCharacters();
      emit(
        CharactersLoaded(
          characters: response.results,
          hasReachedMax: event.page >= response.info.pages,
          currentPage: event.page,
          totalPages: response.info.pages,
        ),
      );
    } catch (e) {
      emit(CharactersError(e.toString()));
    }
  }

  Future<void> _onLoadMoreCharacters(
    LoadMoreCharacters event,
    Emitter<CharactersState> emit,
  ) async {
    final currentState = state;
    if (currentState is CharactersLoaded && !currentState.hasReachedMax) {
      emit(CharactersLoadingMore(currentState.characters));

      try {
        final nextPage = currentState.currentPage + 1;
        final response = await _repository.getCharactersByPagination(nextPage);
        emit(
          currentState.copyWith(
            characters: [...currentState.characters, ...response.results],
            hasReachedMax: nextPage >= response.info.pages,
            currentPage: nextPage,
          ),
        );
      } catch (e) {
        emit(CharactersError(e.toString()));
      }
    }
  }
}
