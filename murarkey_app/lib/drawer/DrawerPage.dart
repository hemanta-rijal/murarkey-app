import 'dart:io';

import 'package:flutter/material.dart';
import 'package:murarkey_app/repository/models/navigation_drawer/MenuItemModel.dart';
import 'package:murarkey_app/routes/NavigateRoute.dart';
import 'package:murarkey_app/utils/AppConstants.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerPage {
  static final _divider = Divider(
    height: 1,
    color: Colors.black,
  );

  static Drawer setDrawer({
    @required BuildContext context,
    @required List<MenuItemModel> menuItemModelList,
  }) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: _setupMenuItemModelList(context, menuItemModelList).toList(),
      ),
    );
  }

  static List<Widget> _setupMenuItemModelList(
      BuildContext context, List<MenuItemModel> menuItemModelList) {
    List<Widget> view = [];
    view.add(
      DrawerHeader(
        decoration: BoxDecoration(
          color: AppConstants.appColor.primaryColor,
        ),
        //Title of header
        child: Image.asset("images/app_logo_golden.png"),
      ),
    );
    for (int i = 0; i < menuItemModelList.length; i++) {
      view.add(
        ListTile(
          title: Text(
            '${menuItemModelList[i].label}',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          //To perform action on tapping at tile
          onTap: () {
            if (menuItemModelList[i].type == "video") {
              launchURL(menuItemModelList[i].data);
              return;
            }

            Map<String, dynamic> arguments = new Map();
            arguments["args"] = menuItemModelList[i];
            NavigateRoute.pop(context);
            NavigateRoute.pushNamedWithArguments(
              context,
              NavigateRoute.DRAWER_CHILD_ITEM,
              arguments,
            );
          },
        ),
      );
      view.add(_divider);
    }
    return view;
  }
}

launchURL(String url) async {
  if (Platform.isIOS) {
    if (await canLaunch('${url}')) {
      await launch('${url}', forceSafariVC: false);
    } else {
      if (await canLaunch('${url}')) {
        await launch('${url}');
      } else {
        throw 'Could not launch ${url}';
      }
    }
  } else {
    // if (await canLaunch('${url}')) {
    //   await launch('${url}');
    // } else {
    //   throw 'Could not launch $url';
    // }
    try {
      await launch('${url}');
    }catch(e){
      print('Could not launch $url');
    }
  }
}
