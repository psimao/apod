import 'package:http/http.dart' as http;
import 'package:apod/environment.dart';
import 'package:apod/models/apod.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

final _URL = "https://api.nasa.gov/planetary";

Future<Apod> getPictureOfTheDay(DateTime date) async {
  final formattedDate = DateFormat("yyyy-MM-dd").format(date);
  final apiKey = await Environment.loadParam(Environment.NASA_API_KEY);
  final url = "$_URL/apod?api_key=$apiKey&hd=True&date=$formattedDate";
  final response = await http.get(url);
  if (response.statusCode == 200) {
    return Apod.fromJson(json.decode(response.body));
  } else {
    throw Exception("Failed to get the astronomy picture of the day.\n${response.body}");
  }
}