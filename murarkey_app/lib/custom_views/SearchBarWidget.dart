import 'package:murarkey_app/utils/Imports.dart';

class SearchBarWidget extends StatelessWidget {
  final String textHint;
  final void Function(String) onTextChange;
  final void Function() onTap;

  SearchBarWidget({this.textHint, this.onTextChange, this.onTap});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    SizeConfig().init(context);

    return Container(
      color: AppConstants.appColor.primaryColor,
      padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0, bottom: 12.0),
      child: TextField(
          onChanged: onTextChange,
          onTap: onTap,
          style: TextStyle(
            fontSize: SizeConfig.textMultiplier * 1.8,
          ),
          decoration: InputDecoration(
              fillColor: AppConstants.appColor.whiteColor.withOpacity(1),
              filled: true,
              suffixIcon:
                  Icon(Icons.search, color: AppConstants.appColor.accentColor),
              hintText: textHint,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none),
              contentPadding: EdgeInsets.only(left: 16.0))),
    );
  }
}
