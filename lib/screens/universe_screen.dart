import 'package:flutter/material.dart';
import 'package:rick_and_morty_universe/services/api_manager/api_manager_service.dart';
import 'package:rick_and_morty_universe/services/characters/characters_service.dart';

class UniverseScreen extends StatelessWidget {
  static const String id = 'universe_screen';
  const UniverseScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            CharactersService charactersService = CharactersService(
              APIManagerService.instance,
            );
            charactersService
                .fetchCharacters()
                .then((response) {
                  // Handle the response, e.g., update the UI or show a dialog
                  print('Fetched ${response.results.length} characters');
                })
                .catchError((error) {
                  // Handle any errors
                  print('Error fetching characters: $error');
                });
          },
          child: Text('Fetch Characters'),
        ),
      ],
    );
  }
}
