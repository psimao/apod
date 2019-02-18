import 'package:meta/meta.dart';
import 'package:apod/models/apod.dart';

@immutable
class ApodState {
  static final firstApodDate = DateTime.utc(1995, 6, 16);

  DateTime date;
  Apod apod;
  bool isLoading;
  Exception exception;

  ApodState(this.date, {this.apod, this.isLoading = false, this.exception});

  factory ApodState.loading(DateTime date) => ApodState(date, isLoading: true);

  factory ApodState.error(DateTime date, Exception e) =>
      ApodState(date, exception: e);

  @override
  bool operator ==(other) {
    return other is ApodState &&
        other != null &&
        other.date.difference(this.date).inDays == 0;
  }

  @override
  int get hashCode => this.date.hashCode;
}

class InvalidApodDateException implements Exception {
  String cause;

  InvalidApodDateException(DateTime apodDate) {
    cause = "APOD date (value: $apodDate) "
        "must be at the same day or after ${ApodState.firstApodDate}";
  }
}
