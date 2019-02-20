import 'package:apod/data/entity_mapper.dart';
import 'package:apod/data/entity/apod.dart';
import 'dart:convert';

class RemoteApodMapper extends EntityMapper<Apod> {
  
  @override
  Apod map(obj) {
    if (obj is String) {
      return _fromJSON(json.decode(obj));
    } else if (obj is Map<String, dynamic>) {
      return _fromJSON(obj);
    } else return null;
  }

  Apod _fromJSON(Map<String, dynamic> json) => Apod(
      copyright: json["copyright"],
      date: json["date"],
      explanation: json["explanation"],
      hdurl: json.containsKey("hdurl") ? json["hdurl"] : null,
      mediaType: json["media_type"],
      title: json["title"],
      url: json["url"]
  );
}