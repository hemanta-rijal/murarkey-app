import 'package:murarkey_app/custom_views/text_view/TextFieldWidget.dart';
import 'package:murarkey_app/custom_views/text_view/TextviewWidget.dart';
import 'package:murarkey_app/utils/Imports.dart';
import 'package:murarkey_app/views/order/place_order/widgets/PaymentCardWidget.dart';

/**
 * Created by Suman Prasad Neupane on 7/3/2021.
 */

class LoadWalletDialogWidget {
  static final double _imageSize = 56;

  static void show(BuildContext context) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.green,
                ),
                height: 100.0, // USE PROVIDED ANIMATION
                width: 100.0,
                //color: Colors.green,
              ),
              // AlertDialog(
              //   shape: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(16.0)),
              //   title: Text('Hello!!'),
              //   content: Text('How are you?'),
              // ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {});
  }

  static List<Widget> _buildItems() {
    return GlobalData.paywith["data"]
        .map((model) {
          return InkResponse(
            onTap: () {
              //widget.onCallBack(model);
            },
            child: Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Container(
                width: _imageSize,
                //height: _imageSize + 10,
                padding: EdgeInsets.all(4),
                child: Image.network(
                  model["imageUrl"],
                  fit: BoxFit.contain,
                  height: _imageSize,
                  width: _imageSize,
                ),
              ),
            ),
          );
        })
        .toList()
        .cast<Widget>();
  }

  static _payWithGridView() {
    return new Container(
      margin: EdgeInsets.only(top: 12),
      height: _imageSize,
      child: new ListView(
        reverse: true,
        scrollDirection: Axis.horizontal,
        children: _buildItems(),
      ),
    );
  }

  static Widget loadDialog() {
    return Column(
      children: [
        SizedBox(
          height: 8,
        ),
        DefaultTextStyle(
          style: TextStyle(),
          child: textView1(
              title: "Recharge Wallet",
              textSize: 2.3,
              color: AppConstants.appColor.primaryColor,
              fontWeight: FontWeight.bold),
        ),
        Container(
          margin: EdgeInsets.only(top: 16, bottom: 16),
          width: double.infinity,
          height: 1,
          color: AppConstants.appColor.primaryLightColor2,
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: DefaultTextStyle(
                style: TextStyle(),
                child: textView1(
                    title: "Amount",
                    textSize: 2.0,
                    color: AppConstants.appColor.blackColor,
                    fontWeight: FontWeight.normal),
              ),
            ),
            Expanded(
              flex: 1,
              child: textField1(
                  keyboardType: TextInputType.number,
                  hint: "Amount",
                  controller: null,
                  margin: EdgeInsets.only(top: 4.0)),
            )
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          children: [
            textView1(
                title: "Payment Method",
                textSize: 2.0,
                color: AppConstants.appColor.blackColor,
                fontWeight: FontWeight.normal),
          ],
        ),
        (GlobalData.paywith != null) ? _payWithGridView() : Container(),
      ],
    );
  }

  static void show2(BuildContext context, Widget view) {
    var screenSize = MediaQuery.of(context).size;
    var height = screenSize.height / 3.6;
    var width = screenSize.width / 1.2;
    SizeConfig().init(context);

    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        //SHADOW EFFECT
        transitionBuilder: (context, a1, a2, widget) {
          return Center(
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: Container(
                height: height * a1.value, // USE PROVIDED ANIMATION
                width: width * a1.value,
                margin: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                  bottom: 16,
                ),
                child: view,
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        // DURATION FOR ANIMATION
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          //return widget;
        });
  }
}
