import 'package:redux/redux.dart';
import 'package:apod/redux/states/app_state.dart';
import 'package:apod/redux/states/apod_state.dart';
import 'package:apod/redux/actions/apod_actions.dart';
import 'package:apod/data/repository/apod_repository.dart';

class LoadApodMiddleware extends MiddlewareClass<AppState> {
  final ApodRepository repository;

  LoadApodMiddleware(this.repository);

  static TypedMiddleware<AppState, LoadApodAction> createTyped(
          ApodRepository repository) =>
      TypedMiddleware<AppState, LoadApodAction>(LoadApodMiddleware(repository));

  @override
  void call(Store<AppState> store, action, NextDispatcher next) {
    final apodDate = _apodDateForIndex(action.index);
    store.dispatch(ApodIsLoadingAction(apodDate));
    if (_isValidApodDate(apodDate)) {
      repository
          .getAstronomyPictureOfTheDay(apodDate)
          .then((apod) => next(ApodLoadedAction(apod)))
          .catchError((e) => next(ApodNotLoadedAction(apodDate, e)));
    } else {
      next(ApodNotLoadedAction(apodDate, InvalidApodDateException(apodDate)));
    }
  }

  DateTime _apodDateForIndex(int index) {
    final now = DateTime.now();
    return now.subtract(Duration(
        days: index,
        hours: now.hour,
        minutes: now.minute,
        seconds: now.second,
        milliseconds: now.millisecond,
        microseconds: now.microsecond));
  }

  bool _isValidApodDate(DateTime date) =>
      date.isAfter(ApodState.firstApodDate) ||
      date.isAtSameMomentAs(ApodState.firstApodDate);
}
