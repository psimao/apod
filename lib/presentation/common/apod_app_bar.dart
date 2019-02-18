import 'package:flutter/material.dart';
import 'package:apod/presentation/theme.dart';

class ApodAppBar extends AppBar {

  ApodAppBar({
    Key key,
    leading,
    automaticallyImplyLeading = true,
    String title,
    actions,
    flexibleSpace,
    bottom,
    elevation = 4.0,
    backgroundColor,
    brightness,
    iconTheme,
    textTheme,
    primary = true,
    centerTitle = true,
    titleSpacing = NavigationToolbar.kMiddleSpacing,
    toolbarOpacity = 1.0,
    bottomOpacity = 1.0
  }): super(
    key: key,
    leading: leading,
    automaticallyImplyLeading: automaticallyImplyLeading,
    title: Text(title, style: apodTitleTextStyle),
    actions: actions,
    flexibleSpace: flexibleSpace,
    bottom: bottom,
    elevation: elevation,
    backgroundColor: backgroundColor,
    brightness: brightness,
    iconTheme: iconTheme,
    textTheme: textTheme,
    primary: primary,
    centerTitle: centerTitle,
    titleSpacing: titleSpacing,
    toolbarOpacity: toolbarOpacity,
    bottomOpacity: bottomOpacity
  );
}