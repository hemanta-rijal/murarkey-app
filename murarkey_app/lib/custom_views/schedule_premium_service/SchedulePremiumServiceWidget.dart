import 'package:murarkey_app/custom_views/UnderlinedTextViewWidget.dart';
import 'package:murarkey_app/utils/Imports.dart';

class SchedulePremiumServiceWidget extends StatefulWidget {
  List modelList;

  SchedulePremiumServiceWidget({Key key, @required this.modelList})
      : super(key: key);

  @override
  _SchedulePremiumServiceWidgetState createState() =>
      _SchedulePremiumServiceWidgetState();
}

class _SchedulePremiumServiceWidgetState
    extends State<SchedulePremiumServiceWidget> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    SizeConfig().init(context);
    String newValue; //= widget.modelList.first;

    textView(String title) {
      return Text(
        title,
        style: TextStyle(
          color: AppConstants.appColor.textColor,
          fontWeight: FontWeight.normal,
          fontSize: SizeConfig.textMultiplier * 2.0,
        ),
      );
    }

    dropDown() {
      return StatefulBuilder(builder: (context, setState) {
        return new DropdownButton(
          items: widget.modelList.map<DropdownMenuItem<String>>((model) {
            return new DropdownMenuItem<String>(
              value: model,//["title"],
              child: new Text(model),//["title"]),
            );
          }).toList(),
          value: newValue,
          isExpanded: true,
          onChanged: (changedValue) {
            setState(() {
              newValue = widget.modelList[widget.modelList.indexOf(changedValue)];
            });
          },
        );
      });
    }

    scheduleForm() {
      return Card(
        color: AppConstants.appColor.backgroundColor,
          elevation: 8,
          shadowColor: AppConstants.appColor.greyColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Container(
            padding: EdgeInsets.all(16.0),
            width: screenSize.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textView("Select a Service"),
                SizedBox(height: 4),
                dropDown(),
                textView("Pick a Date"),

                textView("Phone number"),
              ],
            ),
          ));
    }

    return Container(
      margin: EdgeInsets.only(top: 30, left: 8, right: 8),
      child: Column(
        children: [
          UnderlinedTextViewWidget(
              title: AppConstants.constants.SCHEDULE_PREMIUM_SERVICE),
          scheduleForm(),
        ],
      ),
    );
  }
}
