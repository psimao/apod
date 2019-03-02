import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:apod/presentation/routes.dart';
import 'package:apod/presentation/theme.dart';
import 'package:apod/domain/store/store.dart';

class ApodApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final store = ApodStore();
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: "APOD - Astronomy Picture of the Day",
        theme: appTheme,
        navigatorKey: navigationKeys,
        onGenerateRoute: appRouteFactory,
      ),
    );
  }
}
