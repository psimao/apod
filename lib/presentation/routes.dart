import 'package:flutter/material.dart';
import 'package:apod/presentation/home/home_page.dart';
import 'package:apod/presentation/explanation/explanation_page.dart';
import 'package:apod/domain/entity/navigation.dart';
import 'package:apod/domain/entity/explanation_navigation.dart';

final navigationKeys = GlobalKey<NavigatorState>();

RouteFactory appRouteFactory = (RouteSettings settings) {
  final path = "/${settings.name.split("/")[1]}";
  switch (path) {
    case Routes.home:
      return _homePageRoute(settings);
    case Routes.explanation:
      return _explanationPageRoute(settings);
    default:
      return null;
  }
};

class Routes {
  Routes._internal();

  static const home = "/";
  static const explanation = "/explanation";
}

Route _homePageRoute(RouteSettings settings) => MaterialPageRoute(
    settings: settings, builder: (BuildContext context) => HomePage());

Route _explanationPageRoute(RouteSettings settings) =>
    MaterialPageRoute(settings: settings, builder: (BuildContext context) {
      final date = DateTime.parse(settings.name.split("/")[2]);
      final simpleDate = DateTime(date.year, date.month, date.day);
      return ExplanationPage(simpleDate);
    });

class AppNavigator extends NavigatorDelegate {
  @override
  void navigate(Navigation navigation) {
    switch (navigation.page) {
      case Page.HOME:
        navigationKeys.currentState.pushNamed(Routes.home);
        break;
      case Page.EXPLANATION:
        final date = navigation
            .extras[ExplanationPageNavigation.extraApodDateKey] as DateTime;
        final route = "${Routes.explanation}/${date.toIso8601String()}";
        navigationKeys.currentState.pushNamed(route);
        break;
      default:
        return;
    }
  }
}
