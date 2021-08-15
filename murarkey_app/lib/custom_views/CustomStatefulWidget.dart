import 'package:flutter/services.dart';
import 'package:murarkey_app/custom_views/app_bar/AppBarWidget.dart';
import 'package:murarkey_app/utils/Imports.dart';

class CustomStatefulWidgetState<T> extends State {
  Size screenSize;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: AppConstants.appColor.primaryDarkColor));
    screenSize = MediaQuery.of(context).size;
    SizeConfig().init(context);
  }

  Widget renderWithAppBar(
      {@required String appBarText,
      @required Widget childWidget,
      Widget floatingActionButton,
      Color backgroundColor,
      Color bodybackgroundColor,
      Color backArrowColor,
      Color textColor,
      Widget widget,
      bool showBackbutton,
      double backArrowSize,
      double titleSize,
      double appBarHeight,
      Widget floatingWidget,
      MainAxisAlignment appBarTextAlignment}) {
    if (widget == null) {
      widget = Container();
    }

    return render(
      childWidget: Scaffold(
        floatingActionButton: floatingActionButton,
        backgroundColor: bodybackgroundColor,
        body: SafeArea(
          child: new LayoutBuilder(builder:
              (BuildContext context, BoxConstraints viewportConstraints) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: viewportConstraints.maxHeight,
                      minWidth: viewportConstraints.minWidth,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppBarWidget(
                          title: appBarText,
                          showBackbutton: showBackbutton,
                          mainAxisAlignment: appBarTextAlignment,
                          backgroundColor: backgroundColor,
                          backArrowColor: backArrowColor,
                          textColor: textColor,
                          backArrowSize: backArrowSize,
                          titleSize: titleSize,
                          widget: widget,
                          height: appBarHeight,
                        ),
                        childWidget,
                        // Container(
                        //   // margin: EdgeInsets.all(8),
                        //   child: childWidget,
                        // )
                      ],
                    ),
                  ),
                ),
                floatingWidget != null
                    ? new Positioned(
                        child: new Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: floatingWidget,
                        ),
                      )
                    : Container(),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget renderWithBotomView(
      {@required String appBarText,
      @required Widget childWidget,
      Widget floatingActionButton,
      bool showBackbutton,
      MainAxisAlignment appBarTextAlignment}) {
    return Material(
        color: AppConstants.appColor.backgroundColor,
        child: Scaffold(
          body: Column(
            children: [
              AppBarWidget(
                title: appBarText,
                showBackbutton: showBackbutton,
                mainAxisAlignment: appBarTextAlignment,
              ),
              childWidget,
            ],
          ),
          floatingActionButton: floatingActionButton,
        ));
  }

  Widget renderCustomUI({
    @required Widget childWidget,
    Widget floatingActionButton,
  }) {
    return render(
      childWidget: Scaffold(
        floatingActionButton: floatingActionButton,
        body: SafeArea(
          child: new LayoutBuilder(builder:
              (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: Container(
                    child: childWidget,
                  )
                  //IntrinsicHeight(
                  //  child:
                  //   Column(
                  //     //mainAxisSize: MainAxisSize.min,
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       childWidget,
                  //     ],
                  //   ),
                  //),
                  ),
            );
          }),
        ),
      ),
    );
  }

  Widget render(
      {@required Widget childWidget,
      Color bodybackgroundColor,
      Widget floatingActionButton}) {
    bodybackgroundColor = bodybackgroundColor == null
        ? AppConstants.appColor.backgroundColor
        : bodybackgroundColor;
    return Material(
        color: bodybackgroundColor,
        child: Scaffold(
          backgroundColor: bodybackgroundColor,
          body: childWidget,
          floatingActionButton: floatingActionButton,
        ));
  }
}
