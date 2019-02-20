import 'package:meta/meta.dart';
import 'package:apod/redux/states/apod_state.dart';

@immutable
class AppState {
  final List<ApodState> apods;

  AppState({this.apods = const []});

  factory AppState.initial() => AppState();
}
