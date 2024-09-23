import 'package:chatr/themes/DarkMode%20copy.dart';
import 'package:chatr/themes/lightMode.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {

  ThemeData currThemeData = lightMode;

  ThemeData get themeData =>currThemeData;

  bool get isDarkMode => currThemeData == darkMode;

  set themeData(ThemeData themeData){
    currThemeData = themeData;
    notifyListeners();
  }

  void ToggleTheme(){
    if(currThemeData == lightMode){
      currThemeData = darkMode;
    }
    else{
      currThemeData = lightMode;
    }
  }
}