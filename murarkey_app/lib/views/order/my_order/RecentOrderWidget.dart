import 'package:murarkey_app/custom_views/error_pages/DataNotAvailableWidget.dart';
import 'package:murarkey_app/custom_views/text_view/TextviewWidget.dart';
import 'package:murarkey_app/repository/Repository.dart';
import 'package:murarkey_app/repository/api_call/ApiUrls.dart';
import 'package:murarkey_app/repository/models/order/MyOrderModel.dart';
import 'package:murarkey_app/routes/NavigateRoute.dart';
import 'package:murarkey_app/utils/Imports.dart';

/**
 * Created by Suman Prasad Neupane on 7/23/2021.
 */

class RecentOrderWidget extends StatefulWidget {
  @override
  _RecentOrderWidgetState createState() => _RecentOrderWidgetState();
}

class _RecentOrderWidgetState
    extends CustomStatefulWidgetState<RecentOrderWidget> {
  Repository _repository = new Repository();
  List<MyOrderModel> myOrderModel = new List();
  var _cardSize = 20.0;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() {
    _repository.orderApiService
        .getMyOrderList(url: ApiUrls.MY_ORDER)
        .then((value) {
      myOrderModel = value;
      this.setState(() {});
    });
  }

  navigateToOrderDetails(MyOrderModel myOrderModel, int index) {
    Map<String, dynamic> arguments = new Map();
    arguments["myOrderModel"] = myOrderModel;
    NavigateRoute.pushNamedWithArguments(
        context, NavigateRoute.MY_ORDER_DETAIL, arguments);
  }

  @override
  Widget build(BuildContext context) {
    Widget loadImage(int index) {
      return Container(
        child: Icon(
          Icons.list_alt_sharp,
          size: _cardSize,
          color: AppConstants.appColor.accentColor,
        ),
      );
    }

    Widget buildItems(MyOrderModel model, int index) {
      return Container(
        margin: EdgeInsets.only(left: 4),
        padding:
            EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0, bottom: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    loadImage(index),
                    SizedBox(
                      width: 16,
                    ),
                    textView1(
                        title: "Order ${index + 1}",
                        textSize: 2.2,
                        fontWeight: FontWeight.bold),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: textView1(
                          title: "${model.status.toUpperCase()}",
                          textSize: 1.8,
                          color: Colors.green[900],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 36),
              child: Column(
                children: [
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      textView1(
                          title: model.code,
                          textSize: 2.0,
                          fontWeight: FontWeight.normal),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Amount
                      textView1(
                        title: "${model.payment_method}",
                        textSize: 2.0,
                        color: Colors.blue[700],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //Amount
                      textView1(
                        title: "${model.order_date}",
                        color: AppConstants.appColor.blackColor,
                        textSize: 2.0,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "Amount: ",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: AppConstants.appColor.blackColor,
                            fontSize: SizeConfig.textMultiplier * 2.0,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: "${model.total}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppConstants.appColor.blackColor,
                                fontSize: SizeConfig.textMultiplier * 2.3,
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
          ],
        ),
      );
    }

    Widget verticalView = ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: myOrderModel.length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(top: 8, bottom: 8),
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: InkWell(
                onTap: () {
                  navigateToOrderDetails(myOrderModel[index], index);
                },
                child: buildItems(myOrderModel[index], index),
              ),
            ),
          );
        });

    Widget buildView() {
      return Column(
        children: [
          myOrderModel != null && myOrderModel.length > 0
              ? verticalView
              : Container(
                  margin: EdgeInsets.only(top: 200),
                  child: DataNotAvailableWidget(
                    message: "You have not order anything yet!",
                  ),
                ),
        ],
      );
    }

    return renderWithAppBar(
        appBarText: "My Orders",
        bodybackgroundColor: AppConstants.appColor.backgroundColor2,
        childWidget: buildView());
  }
}
