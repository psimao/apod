import 'package:apod/data/entity/apod.dart';

class LoadApodAction {
  final int index;

  LoadApodAction(this.index);
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

class OpenApodExplanationForDate {
  final DateTime date;

  OpenApodExplanationForDate(this.date);
}