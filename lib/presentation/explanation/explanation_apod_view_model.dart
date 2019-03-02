import 'package:apod/domain/entity/apod.dart';
import 'package:apod/domain/store/store.dart';
import 'package:intl/intl.dart';

class ExplanationApodViewModel {
  final bool isLoading;
  final bool hasError;
  final bool isVideo;
  final String date;
  final String title;
  final String copyright;
  final String explanation;
  final String url;
  final String errorMessage;

  ExplanationApodViewModel(
    this.date, {
    this.isLoading = false,
    this.hasError = false,
    this.isVideo = false,
    this.title = "",
    this.copyright = "",
    this.explanation = "",
    this.url,
    this.errorMessage,
  });

  factory ExplanationApodViewModel.create(ApodStore store, DateTime apodDate) {
    final apodState = store.state.apods[apodDate];
    if (apodState.isLoading) {
      return ExplanationApodViewModel.loading(apodState.date);
    } else if (apodState.exception != null) {
      return ExplanationApodViewModel.error(apodState.date, apodState.exception);
    } else {
      return ExplanationApodViewModel.withApod(
        apodState.date,
        apodState.apod
      );
    }
  }

  factory ExplanationApodViewModel.loading(DateTime date) =>
      ExplanationApodViewModel(_formatDate(date), isLoading: true);

  factory ExplanationApodViewModel.error(DateTime date, Exception e) =>
      ExplanationApodViewModel(_formatDate(date),
          hasError: true, errorMessage: e.toString());

  factory ExplanationApodViewModel.withApod(DateTime date, Apod apod) =>
      ExplanationApodViewModel(_formatDate(date),
          isVideo: apod.mediaType == Apod.TYPE_VIDEO,
          title: apod.title,
          copyright: apod.copyright ?? "NASA",
          explanation: apod.explanation,
          url: apod.url);

  static String _formatDate(DateTime date) =>
      DateFormat.yMMMMd().format(date);
}
