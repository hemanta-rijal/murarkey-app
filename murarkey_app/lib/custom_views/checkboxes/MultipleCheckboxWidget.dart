import 'package:murarkey_app/custom_views/text_view/TextviewWidget.dart';
import 'package:murarkey_app/utils/Imports.dart';

/**
 * Created by Suman Prasad Neupane on 5/25/2021.
 */

multipleCheckbox1(
    Map<String, bool> lists, value, Function(String, bool) onChanged) {
  return ListView(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    children: lists.keys.map((String key) {
      return Container(
        height: 30,
        child:  CheckboxListTile(
          title: textView1(
              title: key.toString(),
              textAlign: TextAlign.start,
              color: AppConstants.appColor.textColor,
              textSize: 1.8,
              fontWeight: FontWeight.normal),
          value: lists[key],
          contentPadding: EdgeInsets.zero,
          dense: true,
          controlAffinity:
          ListTileControlAffinity.leading,
          activeColor: AppConstants.appColor.accentColor,
          checkColor: Colors.white,
          onChanged: (bool value) {
            onChanged.call(key, value);
          },
        )
      );
    }).toList(),
  );
}
