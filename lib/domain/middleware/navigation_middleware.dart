import 'package:redux/redux.dart';
import 'package:apod/domain/states/app_state.dart';
import 'package:apod/domain/actions/navigation_actions.dart';
import 'package:apod/domain/entity/explanation_navigation.dart';
import 'package:apod/domain/entity/navigation.dart';

class NavigationMiddleware extends MiddlewareClass<AppState> {

  final NavigatorDelegate navigatorDelegate;

  NavigationMiddleware(this.navigatorDelegate);

  static TypedMiddleware<AppState, NavigateToExplanationPageAction> createTyped(
      NavigatorDelegate navigatorDelegate) =>
      TypedMiddleware<AppState, NavigateToExplanationPageAction>(NavigationMiddleware(navigatorDelegate));

  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {
    if (action is NavigateToExplanationPageAction) {
      navigatorDelegate.navigate(ExplanationPageNavigation(action.apodDate));
    }
    next(action);
  }
}