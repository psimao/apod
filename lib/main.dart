import 'package:flutter/material.dart';
import 'package:apod/presentation/app.dart';
import 'package:apod/injector.dart';
import 'package:apod/modules.dart';

void main() {
  _inject();
  runApp(ApodApp());
}

void _inject() {
  injector.inject([
    DataModule(),
    DataLocalModule(),
    DataRemoteModule(),
    ReduxModule()
  ]);
}