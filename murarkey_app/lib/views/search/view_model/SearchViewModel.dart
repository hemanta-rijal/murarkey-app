import 'package:murarkey_app/repository/models/brands/BrandModel.dart';
import 'package:murarkey_app/repository/models/category/CategoryModel.dart';
import 'package:murarkey_app/utils/Imports.dart';

/**
 * Created by Suman Prasad Neupane on 6/19/2021.
 */

class SearchViewModel{
   final TextEditingController formMin = new TextEditingController();
   final TextEditingController formMax = new TextEditingController();

   String formSearch = "";
   BrandModel brandValue = null;
   CategoryModel categoryValue = null;

}