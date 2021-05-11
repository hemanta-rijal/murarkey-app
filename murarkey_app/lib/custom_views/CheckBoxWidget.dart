

/*
* Created by Suman Neupane
* */
import 'package:murarkey_app/custom_views/FlatStatefulButton.dart';
import 'package:murarkey_app/utils/Imports.dart';

class CheckboxWidget extends StatefulWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final Color backgroundColor;
  final EdgeInsetsGeometry margin;
  final FontWeight fontWeight;
  final TextStyle textStyle;
  final EdgeInsetsGeometry padding;
  final Function onValueChange;
  final Size screenSize;
  bool value;

  CheckboxWidget({
    Key key,
    this.text,
    this.fontSize,
    this.textColor,
    this.backgroundColor,
    this.fontWeight,
    this.textStyle,
    this.margin,
    this.padding,
    this.onValueChange,
    this.screenSize,
    bool value
  }): super(key: key){
    this.value = value == null? false: value;
  }

  @override
  _CheckboxWidgetState createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  setStyle() {
    return widget.textStyle != null
        ? widget.textStyle
        : TextStyle(
        color: widget.textColor,
        fontSize: widget.fontSize,
        fontWeight: setFontWeight());
  }

  setBackground() {
    return widget.backgroundColor != null ? widget.backgroundColor : AppConstants.appColor.whiteColor;
  }

  setPadding() {
    return widget.padding != null ? widget.padding : null;
  }

  setMargin() {
    return widget.margin != null ? widget.margin : null;
  }

  setFontWeight() {
    return widget.fontWeight != null ? widget.fontWeight : FontWeight.normal;
  }

  setFontSize() {
    return widget.fontSize != null ? widget.fontSize : SizeConfig.textMultiplier * 1.6;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: setMargin(),
        padding: setPadding(),
        child: new Row(
          children: <Widget>[
            new Checkbox(
                value: widget.value,
                onChanged: (bool value) {
                  widget.onValueChange.call(value);
                }),
            Text(
                widget.text,
                style: setStyle(),
            )
          ],
        )
    );
  }
}
