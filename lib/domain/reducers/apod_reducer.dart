import 'package:redux/redux.dart';
import 'package:apod/domain/actions/apod_actions.dart';
import 'package:apod/domain/states/apod_state.dart';

final Reducer<Map<DateTime, ApodState>> apodReducer = combineReducers<Map<DateTime, ApodState>>([
  TypedReducer<Map<DateTime, ApodState>, ApodIsLoadingAction>(_apodLoadingReducer),
  TypedReducer<Map<DateTime, ApodState>, ApodLoadedAction>(_apodLoadedReducer),
  TypedReducer<Map<DateTime, ApodState>, ApodNotLoadedAction>(_apodNotLoadedReducer)
]);

Map<DateTime, ApodState> _apodLoadingReducer(Map<DateTime, ApodState> apods, ApodIsLoadingAction action) {
  final apodState = ApodState.loading(action.apodDate);
  final newMap = Map<DateTime, ApodState>.from(apods);
  newMap[action.apodDate] = apodState;
  return newMap;
}

Map<DateTime, ApodState> _apodLoadedReducer(Map<DateTime, ApodState> apods, ApodLoadedAction action) {
  final apodDate = DateTime.parse(action.apod.date);
  final apodState = ApodState(apodDate, apod: action.apod);
  final newMap = Map<DateTime, ApodState>.from(apods);
  newMap[apodDate] = apodState;
  return newMap;
}

Map<DateTime, ApodState> _apodNotLoadedReducer(Map<DateTime, ApodState> apods, ApodNotLoadedAction action) {
  final apodState = ApodState.error(action.apodDate, action.exception);
  final newMap = Map<DateTime, ApodState>.from(apods);
  newMap[action.apodDate] = apodState;
  return newMap;
}
