import 'package:redux/redux.dart';
import 'package:apod/redux/actions/apod_actions.dart';
import 'package:apod/redux/states/apod_state.dart';

final apodReducer = combineReducers<List<ApodState>>([
  TypedReducer<List<ApodState>, ApodIsLoadingAction>(_apodLoadingReducer),
  TypedReducer<List<ApodState>, ApodLoadedAction>(_apodLoadedReducer),
  TypedReducer<List<ApodState>, ApodNotLoadedAction>(_apodNotLoadedReducer)
]);

List<ApodState> _apodLoadingReducer(List<ApodState> apods, ApodIsLoadingAction action) {
  final apodState = ApodState.loading(action.apodDate);
  final newList = List<ApodState>.from(apods);
  if (newList.contains(apodState)) {
    newList[newList.indexOf(apodState)] = apodState;
  } else {
    newList.add(apodState);
  }
  return newList;
}

List<ApodState> _apodLoadedReducer(List<ApodState> apods, ApodLoadedAction action) {
  final apodDate = DateTime.parse(action.apod.date);
  final apodState = ApodState(apodDate, apod: action.apod);
  final newList = List<ApodState>.from(apods);
  if (newList.contains(apodState)) {
    newList[newList.indexOf(apodState)] = apodState;
  } else {
    newList.add(apodState);
  }
  return newList;
}

List<ApodState> _apodNotLoadedReducer(List<ApodState> apods, ApodNotLoadedAction action) {
  final apodState = ApodState.error(action.apodDate, action.exception);
  final newList = List<ApodState>.from(apods);
  if (newList.contains(apodState)) {
    newList[newList.indexOf(apodState)] = apodState;
  } else {
    newList.add(apodState);
  }
  return newList;
}
