import 'package:flutter/material.dart';
import 'package:rick_and_morty_universe/components/character_tile.dart';

class UniverseScreen extends StatelessWidget {
  static const String id = 'universe_screen';
  const UniverseScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rick and Morty Universe'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: 10, // Example item count
                itemBuilder: (context, index) {
                  return CharacterTile(
                    charcaterAvatarUrl:
                        'https://rickandmortyapi.com/api/character/avatar/${index + 1}.jpeg',
                    characterName: 'Character ${index + 1}',
                  );
                },
              ),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     CharactersService charactersService = CharactersService(
            //       APIManagerService.instance,
            //     );
            //     charactersService
            //         .fetchCharacters()
            //         .then((response) {
            //           // Handle the response, e.g., update the UI or show a dialog
            //           print('Fetched ${response.results.length} characters');
            //         })
            //         .catchError((error) {
            //           // Handle any errors
            //           print('Error fetching characters: $error');
            //         });
            //   },
            //   child: Text('Fetch Characters'),
            // ),
          ],
        ),
      ),
    );
  }
}
