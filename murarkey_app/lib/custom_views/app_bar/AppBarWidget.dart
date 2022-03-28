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
  Color backgroundColor;
  Color backArrowColor;
  Color textColor;
  double backArrowSize;
  double titleSize;
  bool setElevation;
  Widget widget;
  Function onBackPress;

  AppBarWidget({
    this.title,
    double height,
    bool showBackbutton,
    MainAxisAlignment mainAxisAlignment,
    Color backgroundColor,
    Color backArrowColor,
    Color textColor,
    double backArrowSize,
    double titleSize,
    bool setElevation,
    this.widget,
    this.onBackPress,
  }) {
    this.height = height; //== null ? 46 : height;
    this.showBackbutton = showBackbutton == null ? true : showBackbutton;
    this.mainAxisAlignment =
        mainAxisAlignment == null ? MainAxisAlignment.start : mainAxisAlignment;

    this.backgroundColor = backgroundColor == null
        ? AppConstants.appColor.primaryColor
        : backgroundColor;
    this.backArrowColor = backArrowColor == null
        ? AppConstants.appColor.accentColor
        : backArrowColor;
    this.textColor =
        textColor == null ? AppConstants.appColor.accentColor : textColor;

    this.backArrowSize = backArrowSize == null ? 18.0 : backArrowSize;
    this.titleSize = titleSize == null ? 2.0 : titleSize;

    this.setElevation = setElevation == null ? true : setElevation;
  }

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  loadTitle(String text, double textSize) {
    var margin = EdgeInsets.all(12);
    return Container(
      padding: margin,
      child: Text(text,
          textAlign: TextAlign.start,
          style: TextStyle(
              fontSize: SizeConfig.textMultiplier * textSize,
              fontWeight: FontWeight.bold,
              color: widget.textColor)),
    );
  }

  Widget loadImage() {
    return Container(
      margin: EdgeInsets.all(12),
      child: InkResponse(
        child: Icon(
          Icons.arrow_back,
          size: widget.backArrowSize,
          color: widget.backArrowColor,
        ),
        onTap: () {
          NavigateRoute.pop(context);
          if(widget.onBackPress != null){
            widget.onBackPress();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: widget.height,
      color: widget.setElevation? null : widget.backgroundColor,
      alignment: Alignment.centerLeft,
      decoration: widget.setElevation? BoxDecoration(
        //borderRadius: BorderRadius.circular(5.0),
        color: widget.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 6.0,
          ),
        ],
      ): null,
      child: Column(
        children: [
          Row(
            children: [
              widget.showBackbutton ? loadImage() : Container(),
              widget.showBackbutton ? SizedBox(width: 8) : Container(),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: widget.mainAxisAlignment,
                  children: [loadTitle(widget.title, widget.titleSize)],
                ),
              ),
              widget.mainAxisAlignment == MainAxisAlignment.center
                  ? SizedBox(width: 8)
                  : Container(),
              widget.mainAxisAlignment == MainAxisAlignment.center
                  ? SizedBox(width: widget.backArrowSize)
                  : Container()
            ],
          ),
          widget != null ? widget.widget : Container(),
        ],
      ),
    );
  }
}
