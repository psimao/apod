import 'package:redux/redux.dart';
import 'package:apod/states/app_state.dart';
import 'package:apod/states/apod_state.dart';
import 'package:apod/actions/apod_actions.dart';
import 'package:apod/services/apod_service.dart' as apodApi;

final List<Middleware<AppState>> appMiddleware = [
  TypedMiddleware<AppState, LoadApodAction>(LoadApodMiddleware())
];

class LoadApodMiddleware extends MiddlewareClass<AppState> {

  @override
  void call(Store<AppState> store, action, NextDispatcher next) {
    final apodDate = _apodDateForIndex(action.index);

//    if (store.state.apods.contains(ApodState(apodDate))) {
//      return;
//    }

    next(ApodIsLoadingAction(apodDate));

    if (_isValidApodDate(apodDate)) {
      apodApi
          .getPictureOfTheDay(apodDate)
          .then((apod) => next(ApodLoadedAction(apod)))
          .catchError((e) => next(ApodNotLoadedAction(apodDate, e)));
    } else {
      next(ApodNotLoadedAction(
          apodDate,
          InvalidApodDateException(apodDate)));
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
      date.isAfter(ApodState.firstApodDate) || date.isAtSameMomentAs(ApodState.firstApodDate);
}
