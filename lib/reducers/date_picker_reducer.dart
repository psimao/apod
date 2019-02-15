import 'package:redux/redux.dart';
import 'package:apod/actions/date_actions.dart';

final datePickerReducer = combineReducers<DateTime>([
  TypedReducer<DateTime, PickDateAction>(_pickDate)
]);

DateTime _pickDate(DateTime date, PickDateAction action) {
  return date;
}