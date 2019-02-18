import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:apod/routes.dart';
import 'package:apod/presentation/theme.dart';
import 'package:apod/store/store.dart';

void main() => runApp(ApodApp());

class ApodApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final store = ApodStore();
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: "APOD - Astronomy Picture of the Day",
        theme: appTheme,
        routes: appRoutes(store)
      ),
    );
  }
}