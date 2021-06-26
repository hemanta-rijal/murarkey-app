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
  double _imageHeight = 96.0;

  Widget loadImage(String imgUrl) {
    return Image.network(
      imgUrl,
      fit: BoxFit.cover,
      // height: _imageHeight,
      // width: _imageHeight,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onCallback();
      },
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          width: 78,
          padding: const EdgeInsets.only(
              left: 4.0, right: 4.0, top: 8.0, bottom: 8.0),
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
