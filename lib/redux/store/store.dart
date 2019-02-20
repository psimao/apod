import 'package:redux/redux.dart';
import 'package:apod/redux/states/app_state.dart';
import 'package:apod/redux/reducers/app_reducer.dart';
import 'package:apod/redux/middleware/middleware.dart';

class ApodStore extends Store<AppState> {

  ApodStore() : super(
      appReducer,
      initialState: AppState.initial(),
      middleware: appMiddleware
  );
}