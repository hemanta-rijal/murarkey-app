import 'package:flutter/material.dart';
import 'package:murarkey_app/utils/AppConstants.dart';

class RibbonShapeWidget extends StatefulWidget {
  final String text;

  const RibbonShapeWidget({Key key, this.text}) : super(key: key);


  @override
  RibbonShapeWidgetState createState() => RibbonShapeWidgetState();
}

class RibbonShapeWidgetState extends State<RibbonShapeWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Stack(
        children: <Widget>[
          Container(
            //margin: EdgeInsets.only(bottom: 20.0),
            child: ClipPath(
              clipper: ArcClipper(),
              child: Container(
                width: 88.0,
                height: 30.0,
                color: AppConstants.appColor.redColor,
                child: Center(
                  child: Text(
                    '${widget.text}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Positioned(
          //   bottom: 0.0,
          //   child: ClipPath(
          //     clipper: TriangleClipper(),
          //     child: Container(
          //       width: 20.0,
          //       height: 20.0,
          //       color: AppConstants.appColor.redColor2,
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}

class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(15.0, 0.0);

    var firstControlPoint = Offset(7.5, 0.0);
    var firstPoint = Offset(2.0, 3.0);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstPoint.dx,
      firstPoint.dy,
    );

    var secondControlPoint = Offset(0.0, 7.5);
    var secondPoint = Offset(0.0, 15.0);
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondPoint.dx,
      secondPoint.dy,
    );

    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width - 10, size.height / 2);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
