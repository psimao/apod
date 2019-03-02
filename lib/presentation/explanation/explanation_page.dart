import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:apod/presentation/theme.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:apod/domain/states/app_state.dart';
import 'package:apod/domain/actions/apod_actions.dart';
import 'package:apod/presentation/explanation/explanation_apod_view_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ExplanationPage extends StatelessWidget {
  final DateTime apodDate;

  final _dateTextStyle = apodTitleTextStyle.copyWith(fontSize: 24.0);

  final _titleTextStyle = TextStyle(
      fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18.0);
  final _copyrightTextStyle = TextStyle(color: Colors.white);
  final _explanationTextStyle = TextStyle(color: Colors.white54);

  final _cardPadding = EdgeInsets.only(left: 16.0, right: 16.0);
  final _cardElevation = 8.0;

  ExplanationPage(this.apodDate);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemeColors.background,
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return StoreConnector<AppState, ExplanationApodViewModel>(
      onInit: (store) => store.dispatch(LoadApodAction(apodDate)),
      converter: (store) =>
          ExplanationApodViewModel.create(store, apodDate),
      builder: (context, viewModel) => viewModel.isLoading
          ? Center(child: CircularProgressIndicator())
          : viewModel.hasError
              ? Center(
                  child: Text(
                    viewModel.errorMessage,
                    style: _dateTextStyle,
                  ),
                )
              : _bodyContent(context, viewModel),
    );
  }

  Widget _bodyContent(BuildContext context, ExplanationApodViewModel viewModel) =>
      ListView(children: <Widget>[
        _dateText(viewModel.date),
        _media(context, viewModel),
        _title(viewModel.title),
        _copyright(viewModel.copyright),
        _explanation(viewModel.explanation),
      ]);

  Widget _dateText(String date) => Padding(
        padding: EdgeInsets.fromLTRB(16.0, 40.0, 16.0, 16.0),
        child: Text(date, style: _dateTextStyle),
      );

  Widget _media(BuildContext context, ExplanationApodViewModel viewModel) => Card(
      margin: _cardPadding,
      elevation: _cardElevation,
      color: AppThemeColors.cardBackground,
      clipBehavior: Clip.antiAlias,
      child: viewModel.isVideo
          ? _videoWidget(context, viewModel.url)
          : _imageWidget(viewModel.url));

  Widget _title(String title) => Padding(
        padding: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
        child: Text(title, style: _titleTextStyle),
      );

  Widget _copyright(String copyright) => Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0),
        child: Text(copyright, style: _copyrightTextStyle),
      );

  Widget _explanation(String explanation) => Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(explanation, style: _explanationTextStyle),
      );

  Widget _imageWidget(String url) => Image(
        image: CachedNetworkImageProvider(url),
        fit: BoxFit.fitWidth,
      );

  Widget _videoWidget(BuildContext context, String url) => SizedBox(
      height: (MediaQuery.of(context).size.width - 32) * 0.5625,
      child: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
        gestureRecognizers: null,
      ));
}
