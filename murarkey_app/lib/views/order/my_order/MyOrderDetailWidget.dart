import 'package:murarkey_app/custom_views/CustomStatefulWidget.dart';
import 'package:murarkey_app/custom_views/error_pages/DataNotAvailableWidget.dart';
import 'package:murarkey_app/custom_views/text_view/TextviewWidget.dart';
import 'package:murarkey_app/repository/models/order/MyOrderItemModel.dart';
import 'package:murarkey_app/repository/models/order/MyOrderModel.dart';
import 'package:murarkey_app/utils/Imports.dart';
import 'package:murarkey_app/views/order/my_order/widgets/OrderItemTotalWidget.dart';
import 'package:murarkey_app/views/order/my_order/widgets/OrderItemWidgets.dart';

/**
 * Created by Suman Prasad Neupane on 7/23/2021.
 */

class MyOrderDetailWidget extends StatefulWidget {
  final MyOrderModel myOrderModel;

  MyOrderDetailWidget({Key key, this.myOrderModel}) : super(key: key);

  @override
  _MyOrderDetailWidgetState createState() =>
      _MyOrderDetailWidgetState(myOrderModel);
}

class _MyOrderDetailWidgetState
    extends CustomStatefulWidgetState<MyOrderDetailWidget> {
  final MyOrderModel myOrderModel;
  bool isServiceViewExpanded = true;
  bool isProductViewExpanded = true;

  _MyOrderDetailWidgetState(this.myOrderModel);

  Widget loadAssetImage(IconData icon, double size) {
    return Container(
      color: Colors.grey[100],
      child: Icon(
        icon,
        size: size,
        color: AppConstants.appColor.accentColor,
      ),
    );
  }

  Widget verticalView({List<MyOrderItemModel> typeItemList}) {
    return ListView.separated(
      itemCount: typeItemList.length,
      physics: NeverScrollableScrollPhysics(),
      separatorBuilder: (BuildContext context, int index) => Divider(
        thickness: 0.5,
        color: Colors.grey[400],
      ),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return OrderItemWidgets(
          index: index,
          model: typeItemList[index],
        );
      },
    );
  }

  Widget loadAccordingToItemType(
      {String type,
      List<MyOrderItemModel> typeItemList,
      bool expandViews,
      Function(bool) onTap}) {
    return Container(
      margin: EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 8),
      child: Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Container(
            margin: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    textView1(
                        title: type,
                        textSize: 2.2,
                        fontWeight: FontWeight.bold),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: textView1(
                          title: "${myOrderModel.status.toUpperCase()}",
                          textSize: 1.8,
                          color: Colors.green[900],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    InkWell(
                      onTap: () {
                        onTap(!expandViews);
                      },
                      child: loadAssetImage(
                          expandViews
                              ? Icons.arrow_drop_down_sharp
                              : Icons.arrow_drop_up_sharp,
                          30),
                    )
                  ],
                ),
                expandViews
                    ? verticalView(
                        typeItemList: typeItemList,
                      )
                    : Container(),
              ],
            ),
          )),
    );
  }

  Widget buildView() {
    return Column(
      children: [
        myOrderModel != null
            ? Column(
                children: [
                  SizedBox(height: 8),
                  loadAccordingToItemType(
                    type: "Product",
                    typeItemList: myOrderModel.items.products,
                    expandViews: isProductViewExpanded,
                    onTap: (bool value) {
                      isProductViewExpanded = value;
                      setState(() {});
                    },
                  ),
                  loadAccordingToItemType(
                    type: "Service",
                    typeItemList: myOrderModel.items.services,
                    expandViews: isServiceViewExpanded,
                    onTap: (bool value) {
                      isServiceViewExpanded = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: 16),
                  OrderItemTotalWidget(
                    subTotal: "${myOrderModel.sub_total}",
                    shippingCharge: "${myOrderModel.shipping_charge}",
                    tax: "${myOrderModel.tax}",
                    total: "${myOrderModel.total}",
                  ),
                ],
              )
            : Container(
                margin: EdgeInsets.only(top: 200),
                child: DataNotAvailableWidget(
                  message: "You have not order anything yet!",
                ),
              ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return renderWithAppBar(
        appBarText: "My Order Detail",
        bodybackgroundColor: AppConstants.appColor.backgroundColor2,
        childWidget: buildView());
  }
}
