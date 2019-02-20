import 'package:redux/redux.dart';
import 'package:apod/redux/states/app_state.dart';
import 'package:apod/redux/actions/apod_actions.dart';
import 'package:apod/injector.dart';

final TypedMiddleware<AppState, LoadApodAction> _loadApodMiddleware = injector.resolve();

final List<Middleware> appMiddleware = [
  _loadApodMiddleware
];