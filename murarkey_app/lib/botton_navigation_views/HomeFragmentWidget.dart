import 'package:murarkey_app/custom_views/CustomStatefulWidget.dart';
import 'package:murarkey_app/custom_views/ImageSliderWidget.dart';
import 'package:murarkey_app/custom_views/SearchBarWidget.dart';
import 'package:murarkey_app/custom_views/UnderlinedTextViewWidget.dart';
import 'package:murarkey_app/custom_views/our_services/OurServicesWidget.dart';
import 'package:murarkey_app/utils/Imports.dart';

class HomeFragmentWidget extends StatefulWidget {
  @override
  _HomeFragmentWidgetState createState() => _HomeFragmentWidgetState();
}

class _HomeFragmentWidgetState
    extends CustomStatefulWidgetState<HomeFragmentWidget> {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    List imgList = [
      "https://murarkey.com/wp-content/uploads/elementor/thumbs/final-2.00-opxymjpjbwqu4ozp0a4lunbl8tuq1jfarw2ayehy1s.jpg",
      "https://murarkey.com/wp-content/uploads/elementor/thumbs/final-1-opxymjpjbwqu4ozp0a4lunbl8tuq1jfarw2ayehy1s.jpg",
      "https://murarkey.com/wp-content/uploads/elementor/thumbs/final-3-2-opxymjpjbwqu4ozp0a4lunbl8tuq1jfarw2ayehy1s.jpg",
      "https://murarkey.com/wp-content/uploads/elementor/thumbs/rsz_3_banner_3080x806_1-oxpjksbnpig4ug5yo10wf182ffc7fn2tanv4dyamg0.png",
      "https://murarkey.com/wp-content/uploads/elementor/thumbs/2-a-dove-offer-Copy-os1uhd6ra23fj6fl5a8u5cku4bg549frug3o1t07c0.jpg"
    ];

    List iconList = [
      {"title": "Make up at home", "imgUrl": "http://murarkey.surge.sh/img/icons/make-up.svg"},
      {"title": "Bridal makeup", "imgUrl": "http://murarkey.surge.sh/img/icons/bride.svg"},
      {"title": "Haircut at home", "imgUrl": "http://murarkey.surge.sh/img/icons/hair-cut-tool.svg"},
      {"title": "Palour at makeup", "imgUrl": "http://murarkey.surge.sh/img/icons/hairdresser.svg"},
      {"title": "Salon at makeup", "imgUrl": "http://murarkey.surge.sh/img/icons/woman-hair.svg"},
    ];

    return render(
        childWidget: Column(
      children: [
        SearchBarWidget(
            textHint: 'Search by Service or Product',
            onTextChange: (value) {
              print(value);
            }),
        SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              ImageSliderWidget(imgList: imgList),

              //Our Services
              OurServicesWidget(iconLists: iconList,),

              //Our Services
              OurServicesWidget(iconLists: iconList,)
            ],
          ),
        ),
      ],
    ));
  }
}
