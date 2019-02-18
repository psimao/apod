import 'package:apod/states/app_state.dart';
import 'package:apod/reducers/apod_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    apods: apodReducer(state.apods, action)
  );
}