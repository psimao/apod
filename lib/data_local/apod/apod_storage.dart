import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class ApodStorage {
  Future<String> getPictureOfTheDay(DateTime date) async {
    final formattedDate = DateFormat("yyyy-MM-dd").format(date);
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(formattedDate);
  }

  Future<bool> storePictureOfTheDay(DateTime date, String json) async {
    if (json == null) return false;
    final formattedDate = DateFormat("yyyy-MM-dd").format(date);
    final preferences = await SharedPreferences.getInstance();
    return preferences.setString(formattedDate, json);
  }
}
