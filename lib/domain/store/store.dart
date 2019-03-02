import 'package:redux/redux.dart';
import 'package:apod/domain/states/app_state.dart';
import 'package:apod/domain/reducers/app_reducer.dart';
import 'package:apod/domain/middleware/middleware.dart';

class ApodStore extends Store<AppState> {

  ApodStore() : super(
      appReducer,
      initialState: AppState.initial(),
      middleware: appMiddleware
  );
}