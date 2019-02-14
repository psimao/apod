import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class Environment {

  static String _filePath = "environment.json";

  static Future<String> loadParam(String key) async {
    return rootBundle.loadString(_filePath)
        .then((json) => jsonDecode(json)[key]);
  }
}