import 'package:apod/redux/states/app_state.dart';
import 'package:apod/redux/reducers/apod_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    apods: apodReducer(state.apods, action)
  );
}