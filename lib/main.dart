import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_universe/navigation/routes.dart';
import 'package:rick_and_morty_universe/repositories/characters_repository.dart';
import 'package:rick_and_morty_universe/repositories/characters_repository_impl.dart';
import 'package:rick_and_morty_universe/screens/universe_screen.dart';
import 'package:rick_and_morty_universe/services/api_manager/api_manager_service.dart';
import 'package:rick_and_morty_universe/services/characters/characters_service.dart';
import 'package:rick_and_morty_universe/state/bloc/characters_bloc.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<CharactersRepository>(
      create:
          (context) => CharactersRepositoryImpl(
            CharactersService(APIManagerService.instance),
          ),
      child: BlocProvider<CharactersBloc>(
        create:
            (context) => CharactersBloc(context.read<CharactersRepository>()),
        child: MaterialApp(
          title: 'Rick and Morty Universe',
          debugShowCheckedModeBanner: false,
          initialRoute: UniverseScreen.id,
          routes: routes,
        ),
      ),
    );
  }
}
