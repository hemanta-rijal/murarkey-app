import 'package:flutter/cupertino.dart';
import 'package:murarkey_app/utils/Imports.dart';

class PaymentCardWidget extends StatefulWidget {
  final String imageSrc;
  Function() onCallback;

  PaymentCardWidget({Key key, @required this.imageSrc, this.onCallback}) : super(key: key);

  @override
  _PaymentCardWidgetState createState() => _PaymentCardWidgetState();
}

class _PaymentCardWidgetState extends State<PaymentCardWidget> {

  Widget loadImage(String imgUrl) {
    return Image.network(
      imgUrl,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onCallback();
      },
      child: Card(
        elevation: 3.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          child: Column(
            children: [
              loadImage(widget.imageSrc),
            ],
          ),
        ),
      ),
    );
  }
}
