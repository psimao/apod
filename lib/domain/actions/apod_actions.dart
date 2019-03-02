import 'package:apod/domain/entity/apod.dart';

class LoadApodAction {
  final DateTime date;

  LoadApodAction(this.date);
}

class ApodIsLoadingAction {
  final DateTime apodDate;

  ApodIsLoadingAction(this.apodDate);
}

class ApodLoadedAction {
  final Apod apod;

  ApodLoadedAction(this.apod);
}

class ApodNotLoadedAction {
  final DateTime apodDate;
  final Exception exception;

  ApodNotLoadedAction(this.apodDate, this.exception);
}