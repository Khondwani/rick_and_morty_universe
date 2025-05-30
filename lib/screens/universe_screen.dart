import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_universe/components/character_tile.dart';
import 'package:rick_and_morty_universe/models/character_model.dart';
import 'package:rick_and_morty_universe/models/characters_model.dart';
import 'package:rick_and_morty_universe/state/bloc/characters_bloc.dart';
import 'package:rick_and_morty_universe/state/bloc/characters_events.dart';
import 'package:rick_and_morty_universe/state/bloc/characters_state.dart';

class UniverseScreen extends StatefulWidget {
  static const String id = 'universe_screen';

  const UniverseScreen({super.key});

  @override
  State<UniverseScreen> createState() => _UniverseScreenState();
}

class _UniverseScreenState extends State<UniverseScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    // Load initial characters
    context.read<CharactersBloc>().add(LoadCharacters());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<CharactersBloc>().add(LoadMoreCharacters());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rick and Morty Universe'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocBuilder<CharactersBloc, CharactersState>(
          builder: (context, state) {
            List<Character> characters = [];
            bool isLoadingMore = false;
            if (state is CharactersLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CharactersError) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is CharactersLoaded) {
              characters = state.characters;
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(16.0),
                      itemCount: characters.length, // Example item count
                      itemBuilder: (context, index) {
                        return CharacterTile(
                          charcaterAvatarUrl: characters[index].image,
                          characterName: characters[index].name,
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (state is CharactersLoadingMore) {
              isLoadingMore = true;
              characters = state.currentCharacters;
            } else {
              return const Center(child: Text('No characters found.'));
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16.0),
                    itemCount: characters.length,
                    itemBuilder: (context, index) {
                      if (index >= characters.length) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return CharacterTile(
                        charcaterAvatarUrl: characters[index].image,
                        characterName: characters[index].name,
                      );
                    },
                  ),
                ),
                if (isLoadingMore)
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: CircularProgressIndicator(),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
