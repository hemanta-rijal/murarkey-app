import 'package:flutter/material.dart';

/**
 * Created by Suman Prasad Neupane on 3/29/2022.
 */
class ReviewModel {
  int id;
  User user;
  int rating;
  String comment;

  ReviewModel({
    this.id,
    this.user,
    this.rating,
    this.comment,
  });

  ReviewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    rating = json['rating'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['rating'] = this.rating;
    data['comment'] = this.comment;
    return data;
  }
}

class User {
  String name;
  Null profileImage;

  User({this.name, this.profileImage});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['profileImage'] = this.profileImage;
    return data;
  }
}
