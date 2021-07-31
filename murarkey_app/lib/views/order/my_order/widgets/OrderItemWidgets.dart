import 'package:murarkey_app/custom_views/text_view/TextviewWidget.dart';
import 'package:murarkey_app/repository/models/order/MyOrderItemModel.dart';
import 'package:murarkey_app/utils/Imports.dart';

/**
 * Created by Suman Prasad Neupane on 7/31/2021.
 */

class OrderItemWidgets extends StatefulWidget {
  final MyOrderItemModel model;
  final int index;

  const OrderItemWidgets({Key key, this.model, this.index}) : super(key: key);

  @override
  _OrderItemWidgetsState createState() => _OrderItemWidgetsState();
}

class _OrderItemWidgetsState extends State<OrderItemWidgets> {
  Size size;
  var _cardSize = 100.0;

  Widget loadImage(String imgUrl) {
    _cardSize = size.width * 0.25;
    return Image.network(
      imgUrl,
      fit: BoxFit.cover,
      height: _cardSize,
    );
  }

  Widget buildItems(MyOrderItemModel model, int index) {
    return Container(
      padding: EdgeInsets.only(left: 8.0, top: 16.0, right: 8.0, bottom: 16.0),
      child: Row(
        //crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          loadImage(model.image),
          SizedBox(
            width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 4,
              ),

              Container(
                width: size.width - _cardSize - 88,
                child: textView1(
                  title: "${model.name}",
                  fontWeight: FontWeight.bold,
                  color: AppConstants.appColor.blackColor,
                  textSize: 2.0,
                ),
              ),

              SizedBox(
                height: 4,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  textView1(
                      title: "NRP ${model.price}",
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
                    title: "Quantity: ${model.qty}",
                    textSize: 2.0,
                    color: Colors.blue[700],
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
                          text: "${model.price * model.qty}",
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
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    size =  MediaQuery.of(context).size;
    return Container(
      child: buildItems(widget.model, widget.index),
    );
  }
}
