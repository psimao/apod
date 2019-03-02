import 'package:apod/domain/entity/page.dart';
export 'package:apod/domain/entity/page.dart';

abstract class Navigation {

  final Page page;
  final Map<String, dynamic> extras;

  Navigation(this.page, {this.extras});
}

abstract class NavigatorDelegate {

  void navigate(Navigation navigation);
}