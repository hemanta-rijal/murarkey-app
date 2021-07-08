import 'package:murarkey_app/custom_views/load_image/SvgImage.dart';
import 'package:murarkey_app/custom_views/text_view/TextviewWidget.dart';
import 'package:murarkey_app/repository/local/AccountDatas.dart';
import 'package:murarkey_app/utils/Commons.dart';
import 'package:murarkey_app/utils/Imports.dart';
import 'package:murarkey_app/views/wallet/widgets/LoadWalletDialogWidget.dart';

/**
 * Created by Suman Prasad Neupane on 7/3/2021.
 */

class WalletWidget extends StatefulWidget {
  @override
  _WalletWidgetState createState() => _WalletWidgetState();
}

class _WalletWidgetState extends CustomStatefulWidgetState<WalletWidget> {
  List walletModel = AccountDatas.myMalletList;
  double _imageHeight = 38.0;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    var screenSize = MediaQuery.of(context).size;
    SizeConfig().init(context);

    Widget loadImage(String imgUrl) {
      return Image.network(
        imgUrl,
        fit: BoxFit.cover,
        height: _imageHeight,
        width: _imageHeight,
      );
    }

    Widget buildItems(model, int index) {
      String status = model["status"].toString().toUpperCase();
      Color statusColor = Colors.green[600];
      String arrowUri = "images/arrows/ic_sort_up.svg";

      if (status == "FAILURE") {
        statusColor = Colors.red[600];
        arrowUri = "images/arrows/ic_sort_down.svg";
      }

      return Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(color: statusColor, width: 6),
          ),
        ),
        margin: EdgeInsets.only(left: 4),
        padding: EdgeInsets.only(left: 16.0, top: 8.0, right: 8.0, bottom: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    flex: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        loadImage(model["imageUrl"]),
                      ],
                    )),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Remarks
                          textView1(
                              title: model["remarks"],
                              textSize: 2.0,
                              fontWeight: FontWeight.normal),
                        ],
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Amount
                          textView1(
                            title: "${model["payment"]}",
                            textSize: 1.8,
                            color: Colors.blue[900],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Amount
                          textView1(
                            title: "${model["date"]}",
                            textSize: 1.8,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          RichText(
                            text: TextSpan(
                              text: "Balance: ",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: AppConstants.appColor.blackColor,
                                fontSize: SizeConfig.textMultiplier * 1.8,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: "${model["accumulated"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppConstants.appColor.blackColor,
                                    fontSize: SizeConfig.textMultiplier * 2.2,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      //Amount
                      svgImageAssert3(
                        imgUrl: arrowUri,
                        size: 15,
                        color: statusColor,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      textView1(
                          title: "${model["amount"]}",
                          textSize: 1.8,
                          color: statusColor,
                          fontWeight: FontWeight.bold),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget verticalView = ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: walletModel.length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(top: 8, bottom: 8),
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: buildItems(walletModel[index], index),
            ),
          );
        });

    Widget showBalance() {
      return Container(
        margin: EdgeInsets.only(left: 8, right: 8, top: 12, bottom: 8),
        child: InkResponse(
          child: Card(
              elevation: 4.0,
              color: AppConstants.appColor.greenColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: Container(
                margin:
                    EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          flex: 2,
                          child: textView1(
                              title: "Rs. 0",
                              textSize: 2.5,
                              color: AppConstants.appColor.whiteColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Card(
                                    elevation: 1.0,
                                    color:
                                        AppConstants.appColor.greenLightColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Container(
                                      margin: EdgeInsets.all(8),
                                      child: svgImageAssert3(
                                        imgUrl: "images/money/ic_dollar.svg",
                                        size: 20,
                                        color: AppConstants.appColor.whiteColor,
                                      ),
                                    )),
                              ],
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    textView1(
                        title: "Amount in Wallet",
                        textSize: 2.0,
                        color: AppConstants.appColor.whiteColor,
                        fontWeight: FontWeight.normal),
                  ],
                ),
              )),
          onTap: () {
            //LoadWalletDialogWidget.show(context);
          },
        ),
      );
    }

    Widget loadBalance() {
      return Container(
        margin: EdgeInsets.only(left: 8, right: 8, top: 12, bottom: 8),
        child: InkResponse(
          child: Card(
            elevation: 4.0,
            //color: AppConstants.appColor.greenColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: AppConstants.appColor.primaryLightColor2,
                width: 1,
              ),
            ),
            child: Container(
              margin: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Card(
                                  elevation: 1.0,
                                  color:
                                      AppConstants.appColor.primaryLightColor2,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Container(
                                    margin: EdgeInsets.all(8),
                                    child: svgImageAssert3(
                                      imgUrl: "images/maths/ic_add_2.svg",
                                      size: 20,
                                      color: AppConstants.appColor.whiteColor,
                                    ),
                                  )),
                            ],
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Center(
                    child: textView1(
                        title: "Load Wallet",
                        textSize: 2.0,
                        color: AppConstants.appColor.primaryColor,
                        fontWeight: FontWeight.normal),
                  )
                ],
              ),
            ),
          ),
          onTap: () {
            LoadWalletDialogWidget.show2(
                context, LoadWalletDialogWidget.loadDialog());
            //Commons.toastMessage(context, "Coming Soon");
          },
        ),
      );
    }

    Widget menu() {
      return Row(
        children: [
          Expanded(
            flex: 1,
            child: showBalance(),
          ),
          Expanded(
            flex: 1,
            child: loadBalance(),
          )
        ],
      );
    }

    Widget builder() {
      return Column(
        children: [menu(), verticalView],
      );
    }

    return renderWithAppBar(
      appBarText: "My Wallet",
      childWidget: builder(),
    );
  }
}
