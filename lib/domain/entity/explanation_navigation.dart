import 'package:apod/domain/entity/navigation.dart';

class ExplanationPageNavigation implements Navigation {
  static final extraApodDateKey = "apodDate";

  final Map<String, dynamic> _extras = Map();

  ExplanationPageNavigation(DateTime apodDate) {
    _extras[extraApodDateKey] = apodDate;
  }

  @override
  Page get page => Page.EXPLANATION;

  @override
  Map<String, dynamic> get extras => _extras;
}
