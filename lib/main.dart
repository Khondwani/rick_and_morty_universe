import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:rick_and_morty_universe/navigation/routes.dart';
import 'package:rick_and_morty_universe/screens/universe_screen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick and Morty Universe',
      debugShowCheckedModeBanner: false,
      initialRoute: UniverseScreen.id,
      routes: routes,
    );
  }
}
