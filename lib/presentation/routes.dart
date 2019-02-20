import 'package:flutter/material.dart';
import 'package:apod/redux/store/store.dart';
import 'package:apod/presentation/home/home_page.dart';

class Routes {
  Routes._internal();

  static final home = "/";
  static final apodDetails = "/apodDetails";
}

Map<String, WidgetBuilder> appRoutes(ApodStore store) => {
  Routes.home: (context) {
    return HomePage();
  },
  Routes.apodDetails: (context) {

  }
};
