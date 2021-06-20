import 'package:flutter/material.dart';

/**
 * Created by Suman Prasad Neupane on 6/16/2021.
 */

class ProductDetailViewModel {
  TextEditingController formAddToCardItem = new TextEditingController();
  var _count = 1;

  ProductDetailViewModel() {
    formAddToCardItem.text = _count.toString();
  }

  get count => _count;

  int subtract() {
    if (_count < 2) {
      _count = 1;
    } else {
      --_count;
    }

    print("ProductDetailViewModel= " + _count.toString());
    return _count;
  }

  int add() {
    if (_count >= 1) {
      _count++;
    }

    print("ProductDetailViewModel= " + _count.toString());
    return _count;
  }

  int toInt(String s) {
    return int.parse(s);
  }
}
