import 'package:murarkey_app/utils/Imports.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.constants.APP_NAME,
      theme: AppConstants.appTheme.buildTheme(),
      home: LoginWidget(),
    );
  }
}
