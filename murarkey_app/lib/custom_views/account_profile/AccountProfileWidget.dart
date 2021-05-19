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

    loadUserName(String text, double textSize) {
      return Text(text,
          textAlign: TextAlign.start,
          style: TextStyle(
              fontSize: SizeConfig.textMultiplier * textSize,
              fontWeight: FontWeight.bold,
              color: AppConstants.appColor.textColor));
    }

    loadBalance(String text, double textSize) {
      return Text(text,
          textAlign: TextAlign.start,
          style: TextStyle(
              fontSize: SizeConfig.textMultiplier * textSize,
              fontWeight: FontWeight.bold,
              color: AppConstants.appColor.textColor));
    }

    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Card(
            elevation: 6.0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      loadImage(widget.model["imgUrl"]),
                      SizedBox(width: 8),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          loadUserName(
                              widget.model["firstName"] +
                                  " " +
                                  widget.model["lastName"],
                              2.0),
                          SizedBox(height: 4),
                          loadBalance(
                              "Balance: Rs. " + widget.model["balance"], 1.6),
                        ],
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
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
