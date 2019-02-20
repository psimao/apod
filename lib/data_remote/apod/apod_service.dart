import 'package:http/http.dart' as http;
import 'package:apod/environment.dart';
import 'package:intl/intl.dart';

class ApodService {

  final _baseUrl = "https://api.nasa.gov/planetary";

  Future<String> getPictureOfTheDay(DateTime date) async {
    final formattedDate = DateFormat("yyyy-MM-dd").format(date);
    final apiKey = await Environment.loadParam(Environment.NASA_API_KEY);
    final url = "$_baseUrl/apod?api_key=$apiKey&hd=True&date=$formattedDate";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Failed to get the astronomy picture of the day.\n${response.body}");
    }
  }
}