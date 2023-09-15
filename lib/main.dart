import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:expence_tracker/expence_screen.dart';
//To Lock device Orientaion
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//   ]).then((fn) {
//     runApp(MyApp());
//   });
// }

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  ColorScheme colorScheme = ColorScheme.fromSeed(
    //brightness: Brightness.light,
    seedColor: Colors.red,
  );
  ColorScheme kDarkColorScheme = ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: const Color.fromARGB(255, 222, 136, 136));
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 225, 119, 111),
        colorScheme: colorScheme,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          titleTextStyle: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        cardTheme: CardTheme(
          color: colorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(fontSize: 26, color: colorScheme.secondary),
              titleMedium: TextStyle(
                fontSize: 22,
                color: colorScheme.secondary,
              ),
              titleSmall: TextStyle(
                fontSize: 19,
                color: colorScheme.secondary,
              ),
            ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primary,
            textStyle: TextStyle(
              fontSize: 22,
            ),
            elevation: 16,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            //backgroundColor: Colors.black,
            textStyle: TextStyle(
              fontSize: 20,
              color: colorScheme.error,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: kDarkColorScheme.background,
        brightness: Brightness.dark,
        colorScheme: kDarkColorScheme,
        useMaterial3: true,
        appBarTheme: AppBarTheme().copyWith(
          centerTitle: true,
          foregroundColor: kDarkColorScheme.onBackground,
          backgroundColor: kDarkColorScheme.background,
        ),
        cardTheme: CardTheme(
          color: colorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge:
                  TextStyle(fontSize: 26, color: kDarkColorScheme.primary),
              titleMedium:
                  TextStyle(fontSize: 22, color: kDarkColorScheme.secondary),
              titleSmall: TextStyle(
                fontSize: 19,
                color: kDarkColorScheme.primary,
              ),
            ),
      ),
      title: "Expence Tracker",
      home: ExpenceScreen(),
    );
  }
}
