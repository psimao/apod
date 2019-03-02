import 'package:meta/meta.dart';
import 'package:apod/domain/states/apod_state.dart';

@immutable
class AppState {
  final Map<DateTime, ApodState> apods;

  AppState({@required this.apods});

  factory AppState.initial() => AppState(
      apods: const {}
  );
}
