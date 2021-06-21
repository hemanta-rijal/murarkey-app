import 'package:murarkey_app/routes/NavigateRoute.dart';
import 'package:murarkey_app/utils/Imports.dart';

/**
 * Created by Suman Prasad Neupane on 5/19/2021.
 */

class AppBarWidget extends StatefulWidget {
  double height;
  final String title;
  bool showBackbutton;
  MainAxisAlignment mainAxisAlignment;

  AppBarWidget(
      {this.title,
      double height,
      bool showBackbutton,
      MainAxisAlignment mainAxisAlignment}) {
    this.height = height == null ? 56 : height;
    this.showBackbutton = showBackbutton == null ? true : showBackbutton;
    this.mainAxisAlignment =
        mainAxisAlignment == null ? MainAxisAlignment.start : mainAxisAlignment;
  }

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  var _cardSize = 18.0;

  loadTitle(String text, double textSize) {
    return Text(text,
        textAlign: TextAlign.start,
        style: TextStyle(
            fontSize: SizeConfig.textMultiplier * textSize,
            fontWeight: FontWeight.bold,
            color: AppConstants.appColor.accentColor));
  }

  Widget loadImage() {
    return Container(
      margin: EdgeInsets.all(12),
      child: InkResponse(
        child: Icon(
          Icons.arrow_back,
          size: _cardSize,
          color: AppConstants.appColor.accentColor,
        ),
        onTap: () {
          NavigateRoute.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      color: AppConstants.appColor.primaryColor,
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          widget.showBackbutton ? loadImage() : Container(),
          widget.showBackbutton ? SizedBox(width: 8) : Container(),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: widget.mainAxisAlignment,
              children: [loadTitle(widget.title, 2.0)],
            ),
          ),
        ],
      ),
    );
  }
}
