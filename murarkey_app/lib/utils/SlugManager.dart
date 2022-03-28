import 'Imports.dart';

/**
 * Created by Suman Prasad Neupane on 3/25/2022.
 */
class SlugManager {
  static String create({
    String string,
  }) {
    if (string == null || string == "") {
      return "";
    }
    var slug = slugify("${string}");
    print("SlugManager create----------> ${slug}");
    return slug;
  }
}
