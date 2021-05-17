import 'package:murarkey_app/utils/Imports.dart';

/**
 * Created by Suman Prasad Neupane on 5/17/2021.
 */
class AccountProfileWidget extends StatefulWidget {
  var model;

  AccountProfileWidget({Key key, @required this.model}) : super(key: key);

  @override
  _AccountProfileWidgetState createState() => _AccountProfileWidgetState();
}

class _AccountProfileWidgetState extends State<AccountProfileWidget> {
  @override
  Widget build(BuildContext context) {
    var _cardSize = 68.0;

    loadImage(String imgUrl) {
      return Center(
          child: Column(children: <Widget>[
        Container(
          width: _cardSize,
          height: _cardSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image:
                DecorationImage(image: NetworkImage(imgUrl), fit: BoxFit.fill),
          ),
        ),
      ]));
    }

    return Container(
      margin: EdgeInsets.only(top: 20, left: 8, right: 8),
      child: Column(
        children: [
          Card(
            elevation: 6.0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(height: 16),
                    loadImage(widget.model["imgUrl"]),
                    SizedBox(height: 8),
                    Text(
                        widget.model["firstName"] +
                            " " +
                            widget.model["lastName"],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 2.0,
                            fontWeight: FontWeight.bold,
                            color: AppConstants.appColor.textColor)),
                    SizedBox(height: 16),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.all(12),
                      child: Icon(
                        Icons.edit,
                        size: 18,
                        color: AppConstants.appColor.accentColor,
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
