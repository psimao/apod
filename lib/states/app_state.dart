import 'package:meta/meta.dart';
import 'package:apod/models/apod.dart';

@immutable
class AppState {
  final List<Apod> apods;
  final DateTime selectedDate;

  AppState({
    this.apods = const [],
    this.selectedDate
  });

  factory AppState.initial() => AppState();
}
