import 'package:flutter/material.dart';
import 'package:murarkey_app/repository/models/content/ContentCartModel.dart';

/**
 * Created by Suman Prasad Neupane on 6/21/2021.
 */
class CardViewModel {
  List<TextEditingController> productTextList = [];
  TextEditingController totalText = new TextEditingController();

  loadProductTextLists(List<ContentCartModel> contentList) {
    for (int i = 0; i < contentList.length; i++) {
      productTextList.add(TextEditingController());
      productTextList[i].text = contentList[i].qty.toString();
    }
  }


  int subtract(qty) {
    int count = int.parse(qty);
    if (count < 2) {
      count = 1;
    } else {
      --count;
    }

    print("ProductDetailViewModel= " + count.toString());
    return count;
  }

  int add(qty) {
    int count = int.parse(qty);
    if (count >= 1) {
      count++;
    }

    print("ProductDetailViewModel= " + count.toString());
    return count;
  }

  int toInt(String s) {
    return int.parse(s);
  }
}
