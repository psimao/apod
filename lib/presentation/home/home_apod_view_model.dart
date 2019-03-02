import 'package:apod/domain/actions/navigation_actions.dart';
import 'package:apod/domain/store/store.dart';
import 'package:apod/domain/entity/apod.dart';
import 'package:intl/intl.dart';

class HomeApodViewModel {
  final bool isLoading;
  final bool hasError;
  final String day;
  final String month;
  final bool isVideo;
  final String title;
  final String copyright;
  final String explanation;
  final String url;
  final String errorMessage;

  final Function openExplanation;

  HomeApodViewModel(
    this.day,
    this.month, {
    this.isLoading = false,
    this.hasError = false,
    this.isVideo = false,
    this.title = "",
    this.copyright = "",
    this.explanation = "",
    this.url,
    this.openExplanation,
    this.errorMessage,
  });

  factory HomeApodViewModel.create(ApodStore store, DateTime apodDate) {
    final apodState = store.state.apods[apodDate];
    if (apodState.isLoading) {
      return HomeApodViewModel.loading(apodState.date);
    } else if (apodState.exception != null) {
      return HomeApodViewModel.error(apodState.date, apodState.exception);
    } else {
      return HomeApodViewModel.withApod(
        apodState.date,
        apodState.apod,
        openExplanation: () {
          store.dispatch(NavigateToExplanationPageAction(apodState.date));
        },
      );
    }
  }

  factory HomeApodViewModel.loading(DateTime date) =>
      HomeApodViewModel(_formatDay(date), _formatMonth(date), isLoading: true);

  factory HomeApodViewModel.error(DateTime date, Exception e) =>
      HomeApodViewModel(_formatDay(date), _formatMonth(date),
          hasError: true, errorMessage: e.toString());

  factory HomeApodViewModel.withApod(DateTime date, Apod apod,
          {Function openExplanation}) =>
      HomeApodViewModel(_formatDay(date), _formatMonth(date),
          isVideo: apod.mediaType == Apod.TYPE_VIDEO,
          title: apod.title,
          copyright: apod.copyright ?? "NASA",
          explanation: apod.explanation,
          url: apod.url,
          openExplanation: openExplanation);

  static String _formatMonth(DateTime date) =>
      DateFormat(DateFormat.ABBR_MONTH).format(date);

  static String _formatDay(DateTime date) =>
      date.day.toString().padLeft(2, "0");
}
