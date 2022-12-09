import 'package:flutter/material.dart';
import 'package:murarkey_app/custom_views/FlatStatefulButton.dart';
import 'package:murarkey_app/custom_views/text_view/TextFieldWidget.dart';
import 'package:murarkey_app/custom_views/text_view/TextviewWidget.dart';
import 'package:murarkey_app/repository/models/review/ReviewModel.dart';
import 'package:murarkey_app/utils/AppConstants.dart';
import 'package:murarkey_app/utils/SizeConfig.dart';

/**
 * Created by Suman Prasad Neupane on 3/29/2022.
 */
class ReviewWidget extends StatefulWidget {
  final bool reviewable;
  final int averageRate;
  final List<ReviewModel> model;
  final Function(String rating, String comment) callback;

  ReviewWidget({
    Key key,
    @required this.model,
    @required this.callback,
    @required this.reviewable,
    @required this.averageRate,
  }) : super(key: key);

  @override
  _ReviewWidgetState createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends State<ReviewWidget> {
  int rateCountSelected = 0;
  TextEditingController ratingController = TextEditingController();

  Widget divider() {
    return Container(
      width: double.infinity,
      height: 1,
      color: Colors.black26,
    );
  }

  Widget showRatings(index) {
    int rating = widget.model[index].rating;
    List<Widget> lists = [];

    for (int i = 0; i < rating; i++) {
      lists.add(Container(
        child: Icon(
          Icons.star,
          color: AppConstants.appColor.orangeColor,
          size: 18,
        ),
      ));
    }

    for (int i = rating; i < 5; i++) {
      lists.add(Container(
        child: Icon(
          Icons.star_border,
          color: AppConstants.appColor.greyColor,
          size: 18,
        ),
      ));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: lists,
    );
  }

  Widget noReview() {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Center(
        child: Text(
          "There is no review.",
          style: TextStyle(
            color: AppConstants.appColor.greyColor,
          ),
        ),
      ),
    );
  }

  Widget showAllReviews() {
    if (widget.model == null) {
      return noReview();
    } else if (widget.model.length < 1) {
      return noReview();
    }

    return ListView.separated(
      itemCount: widget.model.length,
      physics: NeverScrollableScrollPhysics(),
      separatorBuilder: (BuildContext context, int index) => Divider(
        thickness: 0.5,
        color: Colors.grey[400],
      ),
      shrinkWrap: true,
      itemBuilder: (context, int index) {
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Name
              Row(
                children: [
                  textView1(
                    title: "${widget.model[index].user.name}",
                    textAlign: TextAlign.start,
                    color: AppConstants.appColor.greyColor,
                    textSize: 1.9,
                    fontWeight: FontWeight.normal,
                  ),
                  Expanded(
                    child: showRatings(index),
                  ),
                ],
              ),
              textView1(
                title: "${widget.model[index].comment}",
                textAlign: TextAlign.start,
                color: AppConstants.appColor.blackColor,
                textSize: 1.9,
                fontWeight: FontWeight.normal,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget getRateReviews() {
    List<Widget> lists = [];

    for (int i = 0; i < 5; i++) {
      lists.add(
        InkWell(
          onTap: () {
            setState(() {
              rateCountSelected = i + 1;
            });
          },
          child: Container(
            child: Icon(
              rateCountSelected <= i ? Icons.star_border : Icons.star,
              color: AppConstants.appColor.orangeColor,
              size: 24,
            ),
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: lists,
    );
  }

  Widget reviewProduct() {
    if (widget.reviewable == null) {
      return Container();
    } else if (widget.reviewable) {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Review the product
            Row(
              children: [
                textView1(
                  title: "Rate the product:",
                ),
                Expanded(
                  child: getRateReviews(),
                ),
              ],
            ),
            SizedBox(height: 8),

            //Review the product
            textView1(
              title: "Review the product:",
            ),

            textField2(
              //hint: "Review the product",
              minLines: 4,
              keyboardType: TextInputType.text,
              controller: ratingController,
              margin: EdgeInsets.only(top: 8.0),
            ),
            SizedBox(height: 12),

            SizedBox(height: 18),
            FlatStatefulButton(
              text: "Submit",
              fontSize: SizeConfig.textMultiplier * 1.8,
              textColor: AppConstants.appColor.whiteColor,
              //padding: EdgeInsets.all(screenSize.width * .02),
              backgroundColor: AppConstants.appColor.buttonColor3,
              buttonHeight: 45,
              buttonCurve: 2.0,
              onPressedCallback: () {
                widget.callback(
                  rateCountSelected.toString(),
                  ratingController.text.toString(),
                );
                rateCountSelected = 0;
                ratingController.text = "";
              },
            ),
            SizedBox(height: 48),
          ],
        ),
      );
    }
    return Container();
  }

  Widget averageRating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Icon(
          Icons.star_rate,
          color: Colors.amber,
          size: 24,
        ),
        SizedBox(width: 2),
        textView1(
          title: "${widget.averageRate}/5 ${widget.averageRate} Rating",
          textAlign: TextAlign.start,
          color: AppConstants.appColor.blackColor,
          textSize: 2.2,
          fontWeight: FontWeight.normal,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      child: SizedBox(
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            //Reviews Title
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                textView1(
                  title: "Ratings & Reviews",
                  textAlign: TextAlign.start,
                  color: AppConstants.appColor.blackColor,
                  textSize: 2.2,
                  fontWeight: FontWeight.bold,
                ),
                Expanded(
                  child: averageRating(),
                ),
              ],
            ),
            SizedBox(height: 24),
            reviewProduct(),
            showAllReviews(),
          ],
        ),
      ),
    );
  }
}
