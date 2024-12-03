import 'package:flutter/material.dart';

class Localization {
  static const List<String> languages = ['English', 'Spanish', 'French'];

  static String getLocaleName(Locale locale) {
    return languages[locale.languageCode == 'es'
        ? 1
        : locale.languageCode == 'fr'
        ? 2
        : 0];
  }
}


