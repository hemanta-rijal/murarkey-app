import 'package:murarkey_app/repository/models/our_services/OurServicesSubModel.dart';
import 'package:murarkey_app/repository/models/our_services/OurServicesSubSubModel.dart';
import 'package:murarkey_app/utils/Imports.dart';

/**
 * Created by Suman Prasad Neupane on 7/10/2021.
 */

class ServicesSubItemTabViewWidget extends StatefulWidget {
  final List<OurServicesSubSubModel> modelList;
  final List<Widget> pagesLists;

  ServicesSubItemTabViewWidget({Key key, this.modelList, this.pagesLists})
      : super(key: key);

  @override
  _ServicesSubItemTabViewWidgetState createState() =>
      _ServicesSubItemTabViewWidgetState();
}

class _ServicesSubItemTabViewWidgetState
    extends State<ServicesSubItemTabViewWidget> {
  int _selectedPage = 0;
  PageController _pageController;

  @override
  void initState() {
    _pageController = new PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onChange(int pageNum) {
    setState(() {
      _selectedPage = pageNum;
      _pageController.animateToPage(pageNum,
          duration: Duration(milliseconds: 500),
          curve: Curves.fastLinearToSlowEaseIn);
    });
  }

  List<Widget> renderTabItems() {
    List<Widget> widgetList = new List();
    for (int i = 0; i < widget.modelList.length; i++) {
      widgetList.add(_TabItemWidget(
        width: widget.modelList.length > 3 ? 3.5 : 3,
        text: widget.modelList[i].name,
        url: widget.modelList[i].icon,
        pageNumber: i,
        selectedPage: _selectedPage,
        onPressed: () {
          _onChange(i);
        },
      ));
    }
    return widgetList.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  color: AppConstants.appColor.greyColor2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: renderTabItems(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: PageView(
              onPageChanged: (int page) {
                setState(() {
                  _selectedPage = page;
                });
              },
              controller: _pageController,
              children: widget.pagesLists,
            ),
          )
        ],
      ),
    );
  }
}

class _TabItemWidget extends StatelessWidget {
  var _cardSize = 62.0;

  final String text;
  final String url;

  final int selectedPage;
  final int pageNumber;
  final Function onPressed;
  final double width;

  _TabItemWidget({
    Key key,
    this.text,
    this.url,
    this.selectedPage,
    this.pageNumber,
    this.onPressed,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Widget loadImage(String imgUrl) {
      return Image.network(
        imgUrl,
        fit: BoxFit.cover,
        height: selectedPage == pageNumber ? _cardSize + 6 : _cardSize,
      );
    }

    return Container(
      //width: size.width / width,
      child: InkResponse(
        onTap: () {
          onPressed();
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 1000),
          curve: Curves.fastLinearToSlowEaseIn,
          padding: EdgeInsets.symmetric(
            vertical: selectedPage == pageNumber ? 2.0 : 0,
            horizontal: selectedPage == pageNumber ? 4.0 : 0,
          ),
          margin: EdgeInsets.symmetric(
            vertical: selectedPage == pageNumber ? 0 : 2.0,
            horizontal: selectedPage == pageNumber ? 0 : 4.0,
          ),
          child: Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      shape: BoxShape.rectangle,
                      color: selectedPage == pageNumber
                          ? AppConstants.appColor.whiteColor
                          : AppConstants.appColor.greyColor2),
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(2),
                  child: Container(
                    margin:
                        EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: selectedPage == pageNumber
                              ? SizeConfig.textMultiplier * 2.1
                              : SizeConfig.textMultiplier * 1.9,
                          fontWeight: FontWeight.bold,
                          color: selectedPage == pageNumber
                              ? AppConstants.appColor.primaryColor
                              : AppConstants.appColor.blackColor),
                    ),
                  )),
              SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }
}
