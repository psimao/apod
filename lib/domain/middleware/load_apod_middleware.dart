import 'package:apod/domain/repository/apod_repository.dart';
import 'package:redux/redux.dart';
import 'package:apod/domain/states/app_state.dart';
import 'package:apod/domain/states/apod_state.dart';
import 'package:apod/domain/actions/apod_actions.dart';

class LoadApodMiddleware extends MiddlewareClass<AppState> {
  final ApodRepository repository;

  LoadApodMiddleware(this.repository);

  static TypedMiddleware<AppState, LoadApodAction> createTyped(
          ApodRepository repository) =>
      TypedMiddleware<AppState, LoadApodAction>(LoadApodMiddleware(repository));

  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {
    if (action is LoadApodAction) {
      final simpleDate = DateTime(action.date.year, action.date.month, action.date.day);
      if (Apod.isValidApodDate(simpleDate)) {
        store.dispatch(ApodIsLoadingAction(simpleDate));
        repository
            .getAstronomyPictureOfTheDay(simpleDate)
            .then((apod) => store.dispatch(ApodLoadedAction(apod)))
            .catchError((e) => store.dispatch(ApodNotLoadedAction(simpleDate, e)));
      } else {
        store.dispatch(ApodNotLoadedAction(
            simpleDate, InvalidApodDateException(simpleDate)));
      }
    }
    next(action);
  }
}
