import 'package:apod/models/apod.dart';

class LoadApodAction {
  final DateTime forSpecificDate;

  LoadApodAction(this.forSpecificDate);
}

class ApodLoadedAction {
  final Apod apod;

  ApodLoadedAction(this.apod);
}

class ApodNotLoadedAction {}