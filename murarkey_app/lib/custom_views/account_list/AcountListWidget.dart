import 'dart:ffi';

import 'package:murarkey_app/utils/Imports.dart';

/**
 * Created by Suman Prasad Neupane on 5/17/2021.
 */

class AcountListWidget extends StatefulWidget {
  var modelList;
  Function (Object, int) onTapGridItem;

  AcountListWidget({Key key, @required this.modelList, this.onTapGridItem}) : super(key: key);

  @override
  _AcountListWidgetState createState() => _AcountListWidgetState();
}

class _AcountListWidgetState extends State<AcountListWidget> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    SizeConfig().init(context);

    var _crossAxisCount = 3;
    double _crossAxisSpacing = 8, _mainAxisSpacing = 12, _aspectRatio = 1;
    var width =
        (screenSize.width - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
            _crossAxisCount;
    var height = width / _aspectRatio;
    var _cardSize = 32.0;

    Widget loadImage(int index) {
      return Container(
        margin: EdgeInsets.all(12),
        child: Icon(
          widget.modelList[index]["imgIcon"] as IconData,
          size: _cardSize,
          color: AppConstants.appColor.accentColor,
        ),
      );
    }

    Widget loadText(int index) {
      return Text(widget.modelList[index]["name"],
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: SizeConfig.textMultiplier * 1.6,
              fontWeight: FontWeight.normal,
              color: AppConstants.appColor.textColor));
    }

    Widget loadCardView(int index){
      return Card(
          margin: EdgeInsets.all(12),
          elevation: 6.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)),
          child: Container(
            margin: EdgeInsets.all(4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                loadImage(index),
                SizedBox(width: 8),
                loadText(index),
              ],
            ),
          ));
    }

    Widget loadItemList() {
      return GridView.builder(
          shrinkWrap: true,
          itemCount: widget.modelList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _crossAxisCount,
              crossAxisSpacing: _crossAxisSpacing,
              mainAxisSpacing: _mainAxisSpacing,
              childAspectRatio: _aspectRatio),
          itemBuilder: (BuildContext context, int index) {
            return new InkResponse(
              child: loadCardView(index),
              onTap: (){
                widget.onTapGridItem.call(widget.modelList[index], index);
              },
            );
          });
    }

    return Container(
      margin: EdgeInsets.only(top: 60),
      child: Column(
        children: [
          loadItemList(),
        ],
      ),
    );
  }
}
