import 'package:murarkey_app/utils/Imports.dart';

/*
* Created by Suman Neupane
* */

class EditText extends StatefulWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final EdgeInsetsGeometry margin;
  final FontWeight fontWeight;
  final TextStyle textStyle;
  final TextEditingController controller;
  final IconData icon;
  final TextInputType keyboardType;
  final InputDecoration decoration;
  FocusNode focusNode;
  bool obscureText;

  EditText({
    Key key,
    this.text,
    this.fontSize,
    this.textColor,
    this.fontWeight,
    this.textStyle,
    this.margin,
    this.controller,
    this.keyboardType,
    this.icon,
    this.decoration,
    FocusNode focusNode,
    bool obscureText
  }) : super(key: key) {
    this.focusNode = focusNode;
    this.obscureText = obscureText == null? false: obscureText;
  }

  @override
  _EditTextState createState() => _EditTextState();
}

class _EditTextState extends State<EditText> {

  setStyle() {
    return widget.textStyle != null
        ? widget.textStyle
        : TextStyle(
        color: widget.textColor,
        fontSize: widget.fontSize != null? widget.fontSize: SizeConfig.textMultiplier * 2.5,
        fontWeight: setFontWeight());
  }

  setMargin() {
    return widget.margin != null ? widget.margin : null;
  }

  setFontWeight() {
    return widget.fontWeight != null ? widget.fontWeight : FontWeight.normal;
  }

  setDecoration() {
    return widget.decoration != null ? widget.decoration : _fieldDecoration(icon: widget.icon, label: widget.text);
  }

  // Decoration theme
  InputDecoration _fieldDecoration(
      {@required String label, @required IconData icon}) =>
      InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(style: BorderStyle.solid, color: AppConstants.appColor.primaryDarkColor)),
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Color.fromRGBO(255, 255, 255, 100.0),
        contentPadding: EdgeInsets.only(left: 20.0),
        suffixIcon: IconButton(
            icon: Icon(
              icon,
              color: (label == AppConstants.constants.PASSWORD && ! widget.obscureText)
                  ? Colors.black
                  : new Color(0xFFB8B6B6),
            ),
            onPressed: () {
              setState(() {
                if (label == AppConstants.constants.PASSWORD) {
                  widget.obscureText = ! widget.obscureText;
                }
              });
            }),
        // suffixIcon: Icon(icon, color: new Color(0xFFB8B6B6)),
        labelText: label,
        labelStyle: TextStyle(color: new Color(0xFFB8B6B6)),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: setMargin(),
        child: TextFormField(
          focusNode: widget.focusNode,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          style: setStyle(),
          maxLines: 1,
          autocorrect: false,
          enabled: true,
          obscureText: widget.obscureText,
          decoration: setDecoration(),
        )
    );
  }
}
