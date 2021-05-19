import 'dart:ffi';

import 'package:murarkey_app/utils/Imports.dart';

/**
 * Created by Suman Prasad Neupane on 5/17/2021.
 */

class AcountListWidget extends StatefulWidget {
  var modelList;

  AcountListWidget({Key key, @required this.modelList}) : super(key: key);

  @override
  _AcountListWidgetState createState() => _AcountListWidgetState();
}

class _AcountListWidgetState extends State<AcountListWidget> {
  @override
  Widget build(BuildContext context) {
    Widget loadItemList() {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: widget.modelList.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Container(
                  //height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.all(12),
                        child: Icon(
                          widget.modelList[index]["imgIcon"] as IconData,
                          size: 18,
                          color: AppConstants.appColor.accentColor,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(widget.modelList[index]["name"],
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: SizeConfig.textMultiplier * 1.8,
                              fontWeight: FontWeight.normal,
                              color: AppConstants.appColor.textColor)),
                    ],
                  ),
                ),
                Container(
                  color: AppConstants.appColor.greyColor,
                  height: 0.5,
                )
              ],
            );
          });
    }

    return Container(
      margin: EdgeInsets.only(top: 60),
      child: Column(
        children: [
          Card(
              elevation: 6.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: Container(
                margin: EdgeInsets.only(left: 4, right: 4),
                child: loadItemList(),
              ))
        ],
      ),
    );
  }
}
