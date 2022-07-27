import 'package:murarkey_app/custom_views/UnderlinedTextViewWidget.dart';
import 'package:murarkey_app/utils/Imports.dart';
import 'package:murarkey_app/views/order/place_order/widgets/PaymentCardWidget.dart';

/**
 * Created by Suman Prasad Neupane on 8/1/2021.
 */
//TODO Pay with
//http://newweb.murarkey.com/api/payment_methods?fbclid=IwAR1nmL9SlG9Pi-XOpdmW6pMifFhq45hLtkaBD6lz6GGKW4WdKIibG2JKkWs
class PaymentWithWidget extends StatelessWidget {
  final paywith;
  final Function(int) onTap;

  const PaymentWithWidget({Key key, this.paywith, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var _crossAxisCount = 4;
    double _crossAxisSpacing = 30, _mainAxisSpacing = 20, _aspectRatio = 1;
    var width = (size.width - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    var height = width / _aspectRatio;
    var _cardSize = 32.0;

    Widget payItems() {
      return Container(
        margin: EdgeInsets.only(left: 8, right: 8),
        child: Column(
          children: [
            //UnderlinedTextViewWidget(title: "Pay With"),
            Container(
              margin: EdgeInsets.only(
                left: 4,
                right: 4,
                top: 8,
                bottom: 4,
              ),
              child: Row(
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Payment Options: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppConstants.appColor.blackColor,
                        fontSize: SizeConfig.textMultiplier * 2.3,
                      ),
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                //Expanded(flex: 1, child: Container()),
                Expanded(
                    flex: 1,
                    child: GridView.builder(
                      shrinkWrap: true,
                      //physics: NeverScrollableScrollPhysics(),
                      itemCount:
                          paywith["data"].length, //widget.iconLists.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: _crossAxisCount,
                        crossAxisSpacing: _crossAxisSpacing,
                        mainAxisSpacing: _mainAxisSpacing,
                        childAspectRatio: _aspectRatio,
                      ),
                      itemBuilder: (context, position) {
                        return Container(
                          child: PaymentCardWidget(
                            imageSrc: paywith["data"][position]["imageUrl"],
                            onCallback: () {
                              onTap(position);
                            },
                          ),
                        );
                      },
                    ))
              ],
            )
          ],
        ),
      );
    }

    Widget payment() {
      return Container(
        width: size.width,
        color: AppConstants.appColor.whiteColor,
        margin: EdgeInsets.only(top: 4),
        padding: EdgeInsets.only(top: 8, bottom: 24, left: 8, right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //TODO Pay with
            //http://newweb.murarkey.com/api/payment_methods?fbclid=IwAR1nmL9SlG9Pi-XOpdmW6pMifFhq45hLtkaBD6lz6GGKW4WdKIibG2JKkWs
            payItems(),
          ],
        ),
      );
    }

    return payment();
  }
}
