import 'package:carousel_slider/carousel_slider.dart';
import 'package:murarkey_app/repository/models/homepage_banner/HomepageBannerModel.dart';
import 'package:murarkey_app/utils/Imports.dart';

class ImageSliderWidget extends StatefulWidget {
  //https://pub.dev/packages/carousel_slider
  //https://stackoverflow.com/questions/60458924/use-offline-image-for-slider-in-flutter
  //https://stackoverflow.com/questions/64197752/bad-state-insecure-http-is-not-allowed-by-platform/65578828

  final List<HomepageBannerModel> bannerModelList;
  double bannerHeight;
  double bannerWidth;
  BoxFit imageFit;
  EdgeInsets twoImageMargin;
  Color backgroundColor;

  ImageSliderWidget(
      {Key key,
      @required this.bannerModelList,
      double bannerHeight,
      double bannerWidth,
      BoxFit imageFit,
      double twoImageMargin,
      Color backgroundColor})
      : super(key: key) {
    this.bannerHeight = bannerHeight == null ? 140.0 : bannerHeight;
    this.bannerWidth = bannerWidth;
    this.imageFit = imageFit == null ? BoxFit.fill : imageFit;
    this.twoImageMargin = twoImageMargin == null
        ? EdgeInsets.symmetric(horizontal: 8.0)
        : EdgeInsets.symmetric(horizontal: twoImageMargin);
    this.backgroundColor =
        backgroundColor == null ? Colors.white : backgroundColor;
  }

  @override
  ImageSliderWidgetState createState() => ImageSliderWidgetState();
}

class ImageSliderWidgetState extends State<ImageSliderWidget> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    SizeConfig().init(context);

    callbackFunction(index, reason) {
      setState(() {
        _current = index;
      });
    }

    Widget renderImage(imgUrl) {
      return Container(
        margin: widget.twoImageMargin,
        child: Container(
          width: widget.bannerWidth == null
              ? MediaQuery.of(context).size.width
              : widget.bannerWidth,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              child: Image.network(
                imgUrl,
                fit: widget.imageFit,
              ),
            ),
          ),
        ),
      );
    }

    Widget renderDot() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.bannerModelList.map((model) {
          int index = widget.bannerModelList.indexOf(model);

          return Container(
            width: 5.0,
            height: 5.0,
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _current == index
                  ? Color.fromRGBO(0, 0, 0, 0.9)
                  : Color.fromRGBO(0, 0, 0, 0.4),
            ),
          );
        }).toList(),
      );
    }

    return Padding(
        padding: EdgeInsets.all(0),//EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: CarouselSlider(
                items: widget.bannerModelList.map((model) {
                  return Builder(
                    builder: (BuildContext context) {
                      return renderImage(model.imageUrl);
                    },
                  );
                }).toList(),
                options: CarouselOptions(
                  height: widget.bannerHeight,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 4),
                  autoPlayAnimationDuration: Duration(milliseconds: 1000),
                  autoPlayCurve: Curves.linear,
                  //enlargeCenterPage: true,
                  onPageChanged: (index, reason) =>
                      callbackFunction(index, reason),
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
            //renderDot()
          ],
        ));
  }
}
