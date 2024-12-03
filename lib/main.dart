import 'package:flutter/material.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:note_pad_app/screens/addNoteScreen.dart';
import 'package:note_pad_app/screens/signupScreen.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(  MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Note pad',
      theme: ThemeData().copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5
            ),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
          displayLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onTertiary
          ),
          displaySmall: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
              color: Theme.of(context).colorScheme.onTertiary
          ),

          headlineLarge: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSecondary,
              letterSpacing: 5
          ),
        ),
          cardTheme: CardTheme().copyWith(
            color: Theme.of(context).colorScheme.tertiary,
            shadowColor:  Theme.of(context).colorScheme.tertiary.withOpacity(0.7)
      )

      ),
      home: SignupScreen()
    );
  }
}

