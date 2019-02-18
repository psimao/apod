import 'package:flutter/material.dart';
import 'package:apod/store/store.dart';
import 'package:apod/presentation/home/home_page.dart';

class Routes {
  Routes._internal();

  static final home = "/";
  static final apodDetails = "/apodDetails";
}

Map<String, WidgetBuilder> appRoutes(ApodStore store) => {
  Routes.home: (context) {
    return HomePage(store);
  },
  Routes.apodDetails: (context) {

  }
};
