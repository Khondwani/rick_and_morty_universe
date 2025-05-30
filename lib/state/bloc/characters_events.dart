abstract class CharactersEvent {}

class LoadCharacters extends CharactersEvent {
  final int page;
  final bool isRefresh;

  LoadCharacters({this.page = 1, this.isRefresh = false});
}

class LoadMoreCharacters extends CharactersEvent {}
