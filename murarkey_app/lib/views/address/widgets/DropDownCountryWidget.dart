import 'package:murarkey_app/repository/models/brands/BrandModel.dart';
import 'package:murarkey_app/repository/models/country_list/CountryModel.dart';
import 'package:murarkey_app/utils/Imports.dart';

/**
 * Created by Suman Prasad Neupane on 6/19/2021.
 */

Widget dropDownCountryWidget(
    {@required List<CountryModel> modelList,
    @required value,
    margin,
    @required Function(dynamic) onChange}) {
  return Container(
      height: 35,
      margin: margin ?? EdgeInsets.zero,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(width: 1, color: AppConstants.appColor.greyColor),
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
      child: StatefulBuilder(builder: (context, setState) {
        return new DropdownButtonHideUnderline(
          child: new DropdownButton(
            items: modelList.map<DropdownMenuItem<CountryModel>>((model) {
              return new DropdownMenuItem<CountryModel>(
                value: model,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: _textView(model.name),
                ),
              );
            }).toList(),
            value: value,
            isExpanded: true,
            onChanged: (changedValue) {
              onChange.call(changedValue);
            },
            hint: Padding(
              padding: EdgeInsets.all(8),
              child: _textView("\t-- Select Country--"),
            ),
          ),
        );
      }));
}

_textView(String title) {
  return Text(
    title,
    style: TextStyle(
      color: AppConstants.appColor.textColor,
      fontWeight: FontWeight.normal,
      fontSize: SizeConfig.textMultiplier * 2.0,
    ),
  );
}
