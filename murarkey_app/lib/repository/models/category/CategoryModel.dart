import 'package:json_annotation/json_annotation.dart';

part 'CategoryModel.g.dart';
/**
 * Created by Suman Prasad Neupane on 6/13/2021.
 */

//  "id": 1,
//         "name": "Hair",
//         "slug": "hair",
//         "parent_id": null,
//         "description": "This is hair",
//         "_lft": 1,
//         "_rgt": 2,
//         "product_count": 0,
//         "icon_path": "public/categories/mW2FT7MT1MscRbMy61ShYjRNrH9oOqmRQeGq55NC.svg",
//         "image_path": "public/categories/xmnLKFy5HZMVormi22iMFlJF57E5d8xceHmmUYMd.jpg",
//         "size_chart": null,
//         "featured": 1,
//         "icon_url": "http://newweb.murarkey.com/storage/categories/mW2FT7MT1MscRbMy61ShYjRNrH9oOqmRQeGq55NC.svg",
//         "image_url": "http://newweb.murarkey.com/storage/categories/xmnLKFy5HZMVormi22iMFlJF57E5d8xceHmmUYMd.jpg",
//         "children": []


@JsonSerializable(nullable: false)
class CategoryModel{
  final int id;
  final String name;
  final String slug;
  final String description;
  final String icon_url;
  final String image_url;

  CategoryModel(
      {this.id,
        this.name,
        this.slug,
        this.description,
        this.icon_url,
        this.image_url,});

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}