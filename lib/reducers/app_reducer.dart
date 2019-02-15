import 'package:apod/states/app_state.dart';
import 'package:apod/reducers/apod_reducer.dart';
import 'package:apod/reducers/date_picker_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    apods: apodReducer(state.apods, action),
    selectedDate: datePickerReducer(state.selectedDate, action)
  );
}