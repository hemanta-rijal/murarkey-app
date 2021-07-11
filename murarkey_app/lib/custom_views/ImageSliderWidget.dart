import 'package:carousel_slider/carousel_slider.dart';
import 'package:murarkey_app/repository/models/homepage_banner/HomepageBannerModel.dart';
import 'package:murarkey_app/utils/Imports.dart';

class ImageSliderWidget extends StatefulWidget {
  //https://pub.dev/packages/carousel_slider
  //https://stackoverflow.com/questions/60458924/use-offline-image-for-slider-in-flutter
  //https://stackoverflow.com/questions/64197752/bad-state-insecure-http-is-not-allowed-by-platform/65578828

  final List<HomepageBannerModel> bannerModelList;
  double bannerHeight;

  ImageSliderWidget(
      {Key key, @required this.bannerModelList, double bannerHeight})
      : super(key: key) {
    this.bannerHeight =
        bannerHeight == null ? 140.0 : bannerHeight;
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
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
              color: AppConstants.appColor.backgroundColor2,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              imgUrl,
              fit: BoxFit.contain,
            ),
          ));
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
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
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
                    ))),
            renderDot()
          ],
        ));
  }
}
