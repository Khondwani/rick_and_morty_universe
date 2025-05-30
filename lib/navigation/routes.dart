import 'package:flutter/material.dart';
import 'package:rick_and_morty_universe/screens/universe_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  UniverseScreen.id: (context) => UniverseScreen(),
};
