import 'package:meta/meta.dart';
import 'package:apod/domain/entity/apod.dart';
export 'package:apod/domain/entity/apod.dart';

@immutable
class ApodState {

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
        "must be at the same day or after ${Apod.firstApodDate}";
  }
}
