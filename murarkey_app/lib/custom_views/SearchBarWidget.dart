import 'package:murarkey_app/utils/Imports.dart';

class SearchBarWidget extends StatelessWidget {
  final String textHint;
  final void Function(String) onTextChange;
  final void Function() onTap;
  double height;
  EdgeInsetsGeometry padding;

  SearchBarWidget({
    this.textHint,
    this.onTextChange,
    this.onTap,
    double height,
    EdgeInsetsGeometry padding,
  }) {
    this.height = height == null ? 48 : height;
    this.padding = padding == null
        ? EdgeInsets.only(left: 12.0, right: 12.0, top: 6.0, bottom: 6.0)
        : padding;
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    SizeConfig().init(context);

    return Container(
      height: height,
      color: AppConstants.appColor.primaryColor,
      padding: padding,
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
              contentPadding: EdgeInsets.only(left: 16.0),),),
    );
  }
}
