import 'package:flutter/material.dart';
import 'package:murarkey_app/custom_views/FlatStatefulButton.dart';
import 'package:murarkey_app/custom_views/text_view/TextviewWidget.dart';
import 'package:murarkey_app/utils/AppConstants.dart';
import 'package:murarkey_app/utils/SizeConfig.dart';

/**
 * Created by Suman Prasad Neupane on 3/20/2022.
 */
class BodyWidget extends StatefulWidget {
  final List<String> lists;
  final Function(int index) onTapList;

  BodyWidget({
    Key key,
    @required this.lists,
    @required this.onTapList,
  }) : super(key: key);

  @override
  _BodyWidgetState createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  Widget buttonName(String title, int index) {
    return InkWell(
      onTap: () {
        widget.onTapList(index);
      },
      child: Container(
        margin: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 16,
        ),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: AppConstants.appColor.whiteColor,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        padding: EdgeInsets.all(8),
        child: textView1(
          title: "${title}",
          textSize: 2.3,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.normal,
          color: AppConstants.appColor.primaryColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.lists.length,
        itemBuilder: (context, index) {
          return buttonName(
            widget.lists[index],
            index,
          );
        },
      ),
    );
  }
}
