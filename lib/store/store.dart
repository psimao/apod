import 'package:redux/redux.dart';
import 'package:apod/states/app_state.dart';
import 'package:apod/reducers/app_reducer.dart';
import 'package:apod/middleware/app_middleware.dart';

class ApodStore extends Store<AppState> {

  ApodStore() : super(
      appReducer,
      initialState: AppState.initial(),
      middleware: appMiddleware
  );
}