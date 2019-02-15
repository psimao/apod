import 'package:redux/redux.dart';
import 'package:apod/states/app_state.dart';
import 'package:apod/actions/apod_actions.dart';
import 'package:apod/actions/date_actions.dart';
import 'package:apod/services/apod_service.dart' as apodApi;

final List<Middleware<AppState>> appMiddleware = [
  TypedMiddleware<AppState, LoadApodAction>(_loadApod)
];

Middleware _loadApod = (Store<AppState> store, LoadApodAction action, NextDispatcher next) {
  apodApi
      .getPictureOfTheDay(action.forSpecificDate)
      .then((apod) => store.dispatch(ApodLoadedAction(apod)))
      .catchError((_) => store.dispatch(ApodNotLoadedAction()));
  next(action);
} as Middleware;
