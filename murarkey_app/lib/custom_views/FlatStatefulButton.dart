/*
* Created by Suman Neupane
* */
import 'package:murarkey_app/utils/Imports.dart';

class FlatStatefulButton extends StatefulWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final Color backgroundColor;
  final EdgeInsetsGeometry margin;
  final FontWeight fontWeight;
  final TextStyle textStyle;
  final EdgeInsetsGeometry padding;
  final Function onPressedCallback;

  FlatStatefulButton(
      {Key key,
      this.text,
      this.fontSize,
      this.textColor,
      this.backgroundColor,
      this.fontWeight,
      this.textStyle,
      this.margin,
      this.padding,
      this.onPressedCallback})
      : super(key: key);

  @override
  _FlatStatefulButtonState createState() => _FlatStatefulButtonState();
}

class _FlatStatefulButtonState extends State<FlatStatefulButton> {
  setStyle() {
    return widget.textStyle != null
        ? widget.textStyle
        : TextStyle(
            color: widget.textColor,
            //backgroundColor: setBackground(),
            fontSize: widget.fontSize,
            fontWeight: setFontWeight());
  }

  setBackground() {
    return widget.backgroundColor != null
        ? widget.backgroundColor
        : AppConstants.appColor.whiteColor;
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

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
              height: 50,
              margin: setMargin(),
              child: TextButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(setBackground()),
                      padding: MaterialStateProperty.all(setPadding()),
                      elevation: MaterialStateProperty.all(8),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ))),
                  onPressed: () {
                    widget.onPressedCallback.call();
                  },
                  child: Text(
                    widget.text,
                    style: setStyle(),
                  ))),
        ),
      ],
    );
  }
}
