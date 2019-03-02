import 'package:apod/domain/states/app_state.dart';
import 'package:apod/domain/reducers/apod_reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    apods: apodReducer(state.apods, action)
  );
}