import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youtube_player/youtube_player.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:apod/store/store.dart';
import 'package:apod/presentation/common/apod_app_bar.dart';
import 'package:apod/presentation/common/date_picker.dart';
import 'package:apod/presentation/theme.dart';
import 'package:apod/states/app_state.dart';
import 'package:apod/states/apod_state.dart';
import 'package:apod/models/apod.dart';
import 'package:apod/presentation/home/home_actions.dart';

class HomePage extends StatelessWidget {
  final ApodStore _store;

  HomePage(this._store);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppThemeColors.background,
        appBar: HomePageAppBar(context),
        body: HomePageBody(_store));
  }
}

class HomePageAppBar extends ApodAppBar {
  HomePageAppBar(BuildContext context)
      : super(title: "APOD", actions: <Widget>[
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              showApodDatePicker(context).then((date) {
                // Navigate to explanation screen
              });
            },
          )
        ]);
}

class HomePageBody extends StatelessWidget {
  final ApodStore _store;
  final _pictureOfTodayIndex = 0;

  HomePageBody(this._store) {
    _store.dispatch(LoadApodAction(_pictureOfTodayIndex));
  }

  @override
  Widget build(BuildContext context) => CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
                [HomePictureOfTheDay(), HomeExploreLabel()]),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return HomeApodListRow(index, _store);
              //final date = _getDateTimeForIndex(index);
              //return !_reachedDateLimit(date) ? _buildRow(date) : null;
            }),
          )
        ],
      );
}

class HomePictureOfTheDay extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ConstrainedBox(
      constraints: BoxConstraints(minHeight: 400.0),
      child: Container(
          child: StoreConnector<AppState, ApodState>(
        converter: (store) => store.state.apods.first,
        builder: (context, apodState) {
          if (apodState.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (apodState.apod != null) {
            return _buildHeaderColumn(apodState.apod);
          } else {
            return Center(child: Text(""));
          }
        },
      )));

  Widget _buildHeaderColumn(Apod apod) => Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          _buildHeaderMedia(apod),
          Container(
            width: double.infinity,
            child: _buildHeaderInfo(apod),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black])),
          )
        ],
      );

  Widget _buildHeaderMedia(Apod apod) => Container(
      height: 400.0,
      width: double.infinity,
      child: apod.mediaType == Apod.TYPE_VIDEO
          ? _buildVideoWidget(apod.url)
          : Ink.image(
              image: NetworkImage(apod.url),
              fit: BoxFit.cover,
              child: InkWell(onTap: () {
                // Navigate to explanation page
              }),
            ));

  Widget _buildHeaderInfo(Apod apod) => Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(apod.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 21.0),
              maxLines: 1),
          Text("Copyright ${apod.copyright}",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white54),
              maxLines: 1)
        ],
      ));

  Widget _buildVideoWidget(String url) => url.contains("youtube")
      ? YoutubePlayer(
          source: url, quality: YoutubeQuality.HD, showThumbnail: true)
      : Text("Watch the video on: $url",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white));
}

class HomeExploreLabel extends StatelessWidget {
  final _labelStyle = apodTitleTextStyle.copyWith(fontSize: 18.0);
  final _labelPadding = EdgeInsets.only(top: 32.0, bottom: 32.0);

  @override
  Widget build(BuildContext context) => Padding(
      child: Center(child: Text("Explore", style: _labelStyle)),
      padding: _labelPadding);
}

class HomeApodListRow extends StatelessWidget {
  final int _index;
  final ApodStore _store;

  HomeApodListRow(this._index, this._store);

  @override
  Widget build(BuildContext context) {
    final realIndex = _index + 1; // First item loaded on header
    _store.dispatch(LoadApodAction(realIndex));
    return StoreConnector<AppState, ApodState>(
        converter: (store) => store.state.apods[realIndex],
        builder: (context, apodState) {
          if (apodState.isLoading) {
            return _buildLoadingRow(apodState.date);
          } else if (apodState.apod != null) {
            return _buildRow(apodState.date, apodState.apod);
          } else {
            return Container();
          }
        });
  }

  Widget _buildLoadingRow(DateTime date) => Card(
      color: AppThemeColors.cardBackground,
      margin: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      elevation: 8.0,
      clipBehavior: Clip.antiAlias,
      child: Container(
          height: 96.0,
          width: double.infinity,
          child: Row(children: [
            _buildApodDateLabel(date),
            Expanded(
                child: Padding(
                    padding: EdgeInsets.only(right: 24.0),
                    child: LinearProgressIndicator()))
          ])));

  Widget _buildRow(DateTime date, Apod apod) => Card(
      color: AppThemeColors.cardBackground,
      margin: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      elevation: 8.0,
      clipBehavior: Clip.antiAlias,
      child: Container(
        height: 96.0,
        width: double.infinity,
        child: Row(
          children: [
            _buildApodDateLabel(date),
            _buildApodInfoLabel(apod),
            _buildApodThumbnail(apod)
          ],
        ),
      ));

  Widget _buildApodDateLabel(DateTime apodDate) {
    final month = DateFormat(DateFormat.ABBR_MONTH).format(apodDate);
    final day = apodDate.day.toString().padLeft(2, "0");
    return Padding(
        padding: EdgeInsets.only(left: 24.0, right: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(month,
                style:
                    TextStyle(color: AppThemeColors.textCard, fontSize: 14.0)),
            Text(day,
                style:
                    TextStyle(color: AppThemeColors.textCard, fontSize: 24.0))
          ],
        ));
  }

  Widget _buildApodInfoLabel(Apod apod) => Expanded(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(apod.title,
              overflow: TextOverflow.ellipsis,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              maxLines: 1),
          Text("Copyright ${apod.copyright}",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white54),
              maxLines: 1)
        ],
      ));

  Widget _buildApodThumbnail(Apod apod) => Stack(
        children: <Widget>[
          SizedBox(
            width: 120.0,
            height: double.infinity,
            child: Image.network(apod.url, fit: BoxFit.cover),
          ),
          Container(
              width: 120.0,
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
}
