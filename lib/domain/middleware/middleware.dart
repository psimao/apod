import 'package:redux/redux.dart';
import 'package:apod/domain/states/app_state.dart';
import 'package:apod/domain/actions/apod_actions.dart';
import 'package:apod/domain/actions/navigation_actions.dart';
import 'package:apod/injector.dart';

final TypedMiddleware<AppState, LoadApodAction> _loadApodMiddleware =
    injector.resolve();
final TypedMiddleware<AppState, NavigateToExplanationPageAction>
    _explanationNavigatorMiddleware = injector.resolve();

final List<Middleware> appMiddleware = [
  _explanationNavigatorMiddleware,
  _loadApodMiddleware,
];