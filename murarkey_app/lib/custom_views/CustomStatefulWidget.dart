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
      bool showBackbutton,
      MainAxisAlignment appBarTextAlignment}) {
    return render(
      childWidget: Scaffold(
        floatingActionButton: floatingActionButton,
        body: SafeArea(
          child: new LayoutBuilder(builder:
              (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints:
                    BoxConstraints(minHeight: viewportConstraints.maxHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBarWidget(
                      title: appBarText,
                      showBackbutton: showBackbutton,
                      mainAxisAlignment: appBarTextAlignment,
                    ),
                    childWidget,
                    // Container(
                    //   // margin: EdgeInsets.all(8),
                    //   child: childWidget,
                    // )
                  ],
                ),
              ),
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

  Widget render({@required Widget childWidget, Widget floatingActionButton}) {
    return Material(
        color: AppConstants.appColor.backgroundColor,
        child: Scaffold(
          body: childWidget,
          floatingActionButton: floatingActionButton,
        ));
  }
}
