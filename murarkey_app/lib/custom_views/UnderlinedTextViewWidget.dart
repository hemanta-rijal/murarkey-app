import 'package:murarkey_app/utils/Imports.dart';

class UnderlinedTextViewWidget extends StatefulWidget {
  final String title;

  UnderlinedTextViewWidget({Key key, this.title}): super(key: key);

  @override
  _UnderlinedTextViewWidgetState createState() => _UnderlinedTextViewWidgetState();
}

class _UnderlinedTextViewWidgetState extends State<UnderlinedTextViewWidget> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    SizeConfig().init(context);

    return Column(
      children: [
        Text(
          widget.title,
          style: TextStyle(
            color: AppConstants.appColor.textColor,
            fontSize: SizeConfig.textMultiplier * 2.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 2),
          width: screenSize.width * 0.11,
          height: 2,
          color: AppConstants.appColor.accentColor,
        )
      ],
    );
  }
}
