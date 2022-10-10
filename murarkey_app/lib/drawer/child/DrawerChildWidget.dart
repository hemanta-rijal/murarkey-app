import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:murarkey_app/custom_views/CustomStatefulWidget.dart';
import 'package:murarkey_app/repository/models/navigation_drawer/MenuItemModel.dart';
import 'package:murarkey_app/utils/AppConstants.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerChildWidget extends StatefulWidget {
  final MenuItemModel menuItemModel;

  DrawerChildWidget({Key key, this.menuItemModel}) : super(key: key);

  @override
  _DrawerChildWidgetState createState() =>
      _DrawerChildWidgetState(menuItemModel: menuItemModel);
}

class _DrawerChildWidgetState
    extends CustomStatefulWidgetState<DrawerChildWidget> {
  MenuItemModel menuItemModel;

  _DrawerChildWidgetState({this.menuItemModel});

  @override
  Widget build(BuildContext context) {
    print("${menuItemModel.label}");

    Widget buildView() {
      //     if (menuItemModel.type == "video") {
      //       Widget html = Html(
      //         data: """
      // <video controls>
      //   <source src="https://www.w3schools.com/html/mov_bbb.mp4" />
      // </video>
      // <iframe src="https://www.w3schools.com/html/mov_bbb.mp4"></iframe>""",
      //         tagsList: Html.tags..remove(Platform.isAndroid ? "iframe" : "video"),
      //       );
      //
      //       return Container(child: html);
      //     }
      if (menuItemModel.type == "video") {
        return Container();
      }

      return Container(
        child: Html(
          shrinkWrap: true,
          data: "${menuItemModel.data}",
          style: {
            "body": Style(
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.all(0),
            ),
          },
          //tagsList: Html.tags..remove(Platform.isAndroid ? "iframe" : "video"));
        ),
      );
    }

    return renderWithAppBar(
      appBarText: "${menuItemModel.label}",
      bodybackgroundColor: AppConstants.appColor.backgroundColor2,
      childWidget: buildView(),
    );
  }
}
