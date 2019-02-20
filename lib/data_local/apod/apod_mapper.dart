import 'package:apod/data/entity_mapper.dart';
import 'package:apod/data/entity/apod.dart';
import 'dart:convert';

class LocalApodMapper extends EntityMapper<Apod> {
  final _keyDate = "date";
  final _keyTitle = "title";
  final _keyCopyright = "copyright";
  final _keyMediaType = "media_type";
  final _keyUrl = "url";
  final _keyHDUrl = "hdurl";
  final _keyExplanation = "explanation";

  @override
  Apod map(obj) {
    if (obj is String) {
      return _fromJSON(json.decode(obj));
    } else if (obj is Map<String, dynamic>) {
      return _fromJSON(obj);
    } else
      return null;
  }

  @override
  T transform<T>(Apod entity) {
    if (T is String) {
      return json.encode(_convertToJSON(entity)) as T;
    } else
      return null;
  }

  Map<String, dynamic> _convertToJSON(Apod apod) => {
        _keyDate: apod.date,
        _keyTitle: apod.title,
        _keyCopyright: apod.copyright,
        _keyMediaType: apod.mediaType,
        _keyUrl: apod.url,
        _keyHDUrl: apod.hdurl,
        _keyExplanation: apod.explanation
      };

  Apod _fromJSON(Map<String, dynamic> json) => Apod(
      date: json[_keyDate],
      title: json[_keyTitle],
      copyright: json[_keyCopyright],
      mediaType: json[_keyMediaType],
      url: json[_keyUrl],
      hdurl: json.containsKey(_keyHDUrl) ? json[_keyHDUrl] : null,
      explanation: json[_keyExplanation]);
}
