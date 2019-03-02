import 'package:apod/domain/actions/navigation_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:apod/domain/states/app_state.dart';
import 'package:apod/domain/states/apod_state.dart';
import 'package:apod/domain/actions/apod_actions.dart';
import 'package:apod/presentation/common/apod_app_bar.dart';
import 'package:apod/presentation/common/date_picker.dart';
import 'package:apod/presentation/theme.dart';
import 'package:apod/presentation/home/home_apod_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePage extends StatelessWidget {
  final _title = "APOD";

  var _headerHeight = 400.0;
  final _headerIndex = 0;

  final _labelStyle = apodTitleTextStyle.copyWith(fontSize: 18.0);
  final _labelPadding = EdgeInsets.only(top: 32.0, bottom: 32.0);

  final _cardPadding = EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0);
  final _cardElevation = 8.0;
  final _cardHeight = 96.0;

  final _cardDayTextStyle =
      TextStyle(color: AppThemeColors.textCard, fontSize: 24.0);
  final _cardMonthTextStyle =
      TextStyle(color: AppThemeColors.textCard, fontSize: 14.0);

  final _apodTitleTextStyle =
      TextStyle(fontWeight: FontWeight.bold, color: Colors.white);
  final _apodCopyrightTextStyle = TextStyle(color: Colors.white54);

  final _thumbnailWidth = 120.0;

  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    _headerHeight = MediaQuery.of(_context).size.height * 0.6;
    return Scaffold(
        backgroundColor: AppThemeColors.background,
        appBar: _appBar(),
        body: _body());
  }

  ApodAppBar _appBar() {
    final actions = <Widget>[_pickDateButton()];
    return ApodAppBar(title: _title, actions: actions);
  }

  Widget _body() {
    StoreProvider.of<AppState>(_context)
        .dispatch(LoadApodAction(_apodDateForIndex(_headerIndex)));
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate([_header()]),
        ),
        SliverList(
          delegate: SliverChildListDelegate([_exploreLabel()]),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) => _row(index)),
        )
      ],
    );
  }

  Widget _row(int index) {
    final realIndex = index + 1; // First item loaded on header
    final date = _apodDateForIndex(realIndex);
    if (!Apod.isValidApodDate(date)) return null;
    StoreProvider.of<AppState>(_context).dispatch(LoadApodAction(date));
    return StoreConnector<AppState, HomeApodViewModel>(
        converter: (store) =>
            HomeApodViewModel.create(store, _apodDateForIndex(realIndex)),
        builder: (context, viewModel) {
          final content = viewModel.isLoading
              ? _loadingRow(viewModel)
              : viewModel.hasError
                  ? _errorRow(viewModel)
                  : _contentRow(viewModel);
          return Card(
              color: AppThemeColors.cardBackground,
              margin: _cardPadding,
              elevation: _cardElevation,
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: <Widget>[
                  Container(
                      height: _cardHeight,
                      width: double.infinity,
                      child: content),
                  Container(
                      height: _cardHeight,
                      width: double.infinity,
                      child: InkWell(onTap: viewModel.openExplanation)),
                ],
              ));
        });
  }

  Widget _loadingRow(HomeApodViewModel viewModel) {
    return Row(children: [
      _dateWidget(viewModel.day, viewModel.month),
      Expanded(child: _loadingWidget())
    ]);
  }

  Widget _errorRow(HomeApodViewModel viewModel) {
    return Row(children: [
      _dateWidget(viewModel.day, viewModel.month),
      Expanded(
        child: Padding(
          padding: EdgeInsets.only(right: 24.0),
          child: _errorWidget(viewModel.errorMessage),
        ),
      )
    ]);
  }

  Widget _contentRow(HomeApodViewModel viewModel) {
    return Row(children: [
      _dateWidget(viewModel.day, viewModel.month),
      _apodInfoWidget(viewModel),
      _thumbnailWidget(viewModel)
    ]);
  }

  Widget _loadingWidget() => Padding(
      padding: EdgeInsets.only(left: 24.0, right: 24.0),
      child: LinearProgressIndicator());

  Widget _errorWidget(String errorMessage) =>
      Text(errorMessage, style: TextStyle(color: AppThemeColors.text));

  Widget _dateWidget(String day, String month) {
    return Padding(
        padding: EdgeInsets.only(left: 24.0, right: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(day, style: _cardDayTextStyle),
            Text(month, style: _cardMonthTextStyle)
          ],
        ));
  }

  Widget _apodInfoWidget(HomeApodViewModel viewModel) => Expanded(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(viewModel.title,
              overflow: TextOverflow.ellipsis,
              style: _apodTitleTextStyle,
              maxLines: 1),
          Text(viewModel.copyright,
              overflow: TextOverflow.ellipsis,
              style: _apodCopyrightTextStyle,
              maxLines: 1)
        ],
      ));

  Widget _thumbnailWidget(HomeApodViewModel viewModel) => Stack(
        children: <Widget>[
          SizedBox(
            width: _thumbnailWidth,
            height: double.infinity,
            child: viewModel.isVideo
                ? _videoPlaceholderWidget()
                : _imageWidget(viewModel.url),
          ),
          Container(
              width: _thumbnailWidth,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                    AppThemeColors.cardBackground,
                    Colors.transparent
                  ])))
        ],
      );

  Widget _imageWidget(String url) => FadeInImage(
        image: CachedNetworkImageProvider(url),
        placeholder: MemoryImage(kTransparentImage),
        fit: BoxFit.cover,
      );

  Widget _videoPlaceholderWidget() => Image.asset(
        "assets/drawables/video_placeholder.png",
        fit: BoxFit.cover,
      );

  Widget _videoWidget(String url) => WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
        gestureRecognizers: null,
      );

  Widget _header() => ConstrainedBox(
      constraints: BoxConstraints(minHeight: _headerHeight),
      child: Container(
          child: StoreConnector<AppState, HomeApodViewModel>(
        converter: (store) =>
            HomeApodViewModel.create(store, _apodDateForIndex(_headerIndex)),
        builder: (context, viewModel) {
          final content = viewModel.isLoading
              ? Center(child: _loadingWidget())
              : viewModel.hasError
                  ? Center(
                      child: Padding(
                          padding: EdgeInsets.all(24.0),
                          child: _errorWidget(viewModel.errorMessage)))
                  : _headerMedia(viewModel);
          return Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                  height: _headerHeight,
                  width: double.infinity,
                  child: content),
              _headerInfoContainer(viewModel.title, viewModel.copyright),
              Container(
                  width: double.infinity,
                  height: _headerHeight,
                  child: InkWell(onTap: viewModel.openExplanation))
            ],
          );
        },
      )));

  Widget _headerInfoContainer(String title, String copyright) => Container(
        width: double.infinity,
        child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 21.0),
                    maxLines: 1),
                Text(copyright,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white54),
                    maxLines: 1)
              ],
            )),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black])),
      );

  Widget _headerMedia(HomeApodViewModel viewModel) => viewModel.isVideo
      ? _videoWidget(viewModel.url)
      : _imageWidget(viewModel.url);

  Widget _exploreLabel() => Padding(
      child: Center(child: Text("Explore", style: _labelStyle)),
      padding: _labelPadding);

  Widget _pickDateButton() {
    return IconButton(
      icon: Icon(Icons.calendar_today),
      onPressed: () {
        showApodDatePicker(_context).then((date) {
          StoreProvider.of<AppState>(_context)
              .dispatch(NavigateToExplanationPageAction(date));
        }).catchError((e) => print(e.toString()));
      },
    );
  }

  DateTime _apodDateForIndex(int index) {
    var now = DateTime.now();
    var easternDiff = 5 + now.timeZoneOffset.inHours;
    var easternDate = now.subtract(Duration(
        days: index,
        hours: easternDiff,
    ));
    return DateTime(easternDate.year, easternDate.month, easternDate.day);
  }
}
