import 'package:flutter/cupertino.dart';
import 'package:murarkey_app/utils/Imports.dart';

class SocialMediaLoginCardWidget extends StatefulWidget {
  final String text;
  final Color textColor;
  final double fontSize;
  final String imageSrc;

  SocialMediaLoginCardWidget(
      {Key key,
      @required this.text,
      this.textColor,
      @required this.fontSize,
      @required this.imageSrc})
      : super(key: key);

  @override
  _SocialMediaLoginCardWidgetState createState() =>
      _SocialMediaLoginCardWidgetState();
}

class _SocialMediaLoginCardWidgetState
    extends State<SocialMediaLoginCardWidget> {
  setStyle() {
    return TextStyle(
      color: widget.textColor,
      fontSize: widget.fontSize,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("Tapped");
      },
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          width: 78,
          padding: const EdgeInsets.only(
              left: 4.0, right: 4.0, top: 8.0, bottom: 8.0),
          child: Column(
            children: [
              Image.asset(
                widget.imageSrc,
                height: 20,
                width: 20,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                widget.text,
                style: setStyle(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
