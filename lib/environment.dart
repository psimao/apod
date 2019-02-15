import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class Environment {

  static final String NASA_API_KEY = "nasa_api_key";

  static String _filePath = "environment.json";

  Environment._internal();

  static Future<String> loadParam(String key) async {
    return rootBundle.loadString(_filePath)
        .then((json) => jsonDecode(json)[key]);
  }
}