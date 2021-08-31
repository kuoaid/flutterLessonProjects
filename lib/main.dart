import 'package:first_flutter_app/ui/home.dart';
import 'package:first_flutter_app/ui/prject2.dart';
import 'package:first_flutter_app/ui/movie.dart';
import 'package:flutter/material.dart';
/*
2
Use IMPORT to import the necessary files.
Separate the stuff into folders and files help organize code.
 */

/*
3: material design
Help app/web developers design UI elements that are related to the real world.
UI mimics the paper/plastic/materials of real life with shadows, motions, and stuff.
 */

/*
4: Scaffolding
 */


final ThemeData _appTheme = _buildAppTheme();

TextTheme _appTextTheme(TextTheme base) {
  return base.copyWith(
    headline1: base.headline1!.copyWith(
      fontWeight: FontWeight.w500,
    ),
    headline6: base.headline6!.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 14,
    ),
    bodyText2: base.bodyText2!.copyWith(
      fontSize: 40,
    ),
    button: base.button!.copyWith(
      letterSpacing: 3,
      backgroundColor: Colors.green,
    )
  ).apply(
    //this applies to everything above.
  );
}

ThemeData _buildAppTheme() {
  final ThemeData baseTheme = ThemeData.dark();
  return baseTheme.copyWith(
    brightness: Brightness.dark,
    accentColor: Colors.amber[100],
    primaryColor: Colors.green,
    backgroundColor: Colors.amber,
    scaffoldBackgroundColor: Colors.red,
    textTheme: _appTextTheme(baseTheme.textTheme)
  );
}

void main() => runApp(new MaterialApp(
  //theme: _appTheme,
  home: QuizApp(),
      )/**/
    );