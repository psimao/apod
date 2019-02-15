import 'package:redux/redux.dart';
import 'package:apod/actions/apod_actions.dart';
import 'package:apod/models/apod.dart';

final apodReducer = combineReducers<List<Apod>>([
  TypedReducer<List<Apod>, LoadApodAction>(_loadApod)
]);

List<Apod> _loadApod(List<Apod> apods, LoadApodAction action) {
  return apods;
}