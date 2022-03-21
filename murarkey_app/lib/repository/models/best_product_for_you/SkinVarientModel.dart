import 'package:flutter/material.dart';

/**
 * Created by Suman Prasad Neupane on 3/21/2022.
 */
class SkinVarientModel {
  String title;
  String detail;
  String slug;
  List<SkinVarientData> data;

  SkinVarientModel({this.title, this.detail, this.slug, this.data});

  SkinVarientModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    detail = json['detail'];
    slug = json['slug'];
    if (json['data'] != null) {
      data = <SkinVarientData>[];
      json['data'].forEach((v) {
        data.add(new SkinVarientData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['detail'] = this.detail;
    data['slug'] = this.slug;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SkinVarientData {
  String title;
  String slug;

  SkinVarientData({this.title, this.slug});

  SkinVarientData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['slug'] = this.slug;
    return data;
  }
}