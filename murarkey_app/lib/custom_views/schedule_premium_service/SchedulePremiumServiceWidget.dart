import 'package:intl/intl.dart';
import 'package:murarkey_app/custom_views/EditText.dart';
import 'package:murarkey_app/custom_views/FlatStatefulButton.dart';
import 'package:murarkey_app/custom_views/UnderlinedTextViewWidget.dart';
import 'package:murarkey_app/utils/Commons.dart';
import 'package:murarkey_app/utils/Imports.dart';

class SchedulePremiumServiceWidget extends StatefulWidget {
  //https://stackoverflow.com/questions/60180755/setstate-resets-datepicker-and-do-not-change-the-text

  List modelList;

  SchedulePremiumServiceWidget({Key key, @required this.modelList})
      : super(key: key);

  @override
  _SchedulePremiumServiceWidgetState createState() =>
      _SchedulePremiumServiceWidgetState();
}

class _SchedulePremiumServiceWidgetState
    extends State<SchedulePremiumServiceWidget> {
  DateTime currentDate = DateTime.now();
  String dateTimeString = "";
  String newValue;
  TextEditingController phoneController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    SizeConfig().init(context);

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
        return new DropdownButtonHideUnderline(
            child: new DropdownButton(
          items: widget.modelList.map<DropdownMenuItem<String>>((model) {
            return new DropdownMenuItem<String>(
              value: model, //["title"],
              child: Padding(
                padding: EdgeInsets.all(8),
                child: textView(model),
              ), //["title"]),
            );
          }).toList(),
          value: newValue,
          isExpanded: true,
          onChanged: (changedValue) {
            setState(() {
              newValue =
                  widget.modelList[widget.modelList.indexOf(changedValue)];
            });
          },
        ));
      });
    }

    Future<void> _selectDate(BuildContext context) async {
      final DateTime pickedDate = await showDatePicker(
          context: context,
          initialDate: currentDate,
          firstDate: DateTime(2015),
          lastDate: DateTime(2050));
      if (pickedDate != null && pickedDate != currentDate) {
        currentDate = pickedDate;
        String date = DateFormat("yyyy-MM-dd").format(pickedDate);
        print(date);
        setState(() {
          dateTimeString = date;
        });
      }
    }

    Widget selectDateTime() {
      return InkWell(
          onTap: () => _selectDate(context),
          child: Container(
            //height: 35,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border:
                  Border.all(width: 1, color: AppConstants.appColor.greyColor),
              borderRadius: BorderRadius.all(Radius.circular(2)),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              // Align however you like (i.e .centerRight, centerLeft)
              child: Padding(
                padding: EdgeInsets.all(8),
                child: textView(dateTimeString),
              ),
            ),
          ));
    }

    scheduleForm() {
      return Card(
          //color: AppConstants.appColor.appbackgroundColor,
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
                Container(
                  height: 35,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(
                        width: 1, color: AppConstants.appColor.greyColor),
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                  ),
                  child: dropDown(),
                ),
                SizedBox(height: 12),
                textView("Pick a Date"),
                SizedBox(height: 4),
                selectDateTime(),
                SizedBox(height: 12),
                textView("Phone number"),
                Container(
                  height: 35,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(
                        width: 1, color: AppConstants.appColor.greyColor),
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 2.0, color: AppConstants.appColor.textColor),
                        decoration: new InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        )),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),

                //Schedule
                new FlatStatefulButton(
                  text: AppConstants.constants.BUTTON_SCHEDULE,
                  fontSize: SizeConfig.textMultiplier * 2.0,
                  textColor: AppConstants.appColor.accentColor,
                  padding: EdgeInsets.all(screenSize.width * .02),
                  backgroundColor: AppConstants.appColor.buttonColor,
                  buttonHeight: 40,
                  onPressedCallback: () {
                    Commons.toastMessage(context, "Successfully Schedule order.");
                    // String emailValidate = Validation.validateEmail(
                    //     widget.viewModel.formEmail.text.trim());
                    // String passwordValid = Validation.validatePassword(
                    //     widget.viewModel.formPassword.text.trim());
                    //
                    // if (emailValidate != Validation.SUCCESS) {
                    //   Commons.toastMessage(context, emailValidate);
                    // } else if (passwordValid != Validation.SUCCESS) {
                    //   Commons.toastMessage(context, passwordValid);
                    // } else {
                    //   Commons.toastMessage(context, "Successfully login");
                    //   NavigateRoute.popAndPushNamed(context, NavigateRoute.HOME);
                    // }
                  },
                ),
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
          SizedBox(height: 12),
          scheduleForm(),
        ],
      ),
    );
  }
}
