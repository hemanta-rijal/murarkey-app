import 'package:murarkey_app/routes/NavigateRoute.dart';
import 'package:murarkey_app/utils/Imports.dart';
import 'package:murarkey_app/views/auth/register/RegisterWidget.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      //debugShowCheckedModeBanner: false,
      title: AppConstants.constants.APP_NAME,
      theme: AppConstants.appTheme.buildTheme(),
      onGenerateRoute: NavigateRoute.generateRoute,
      initialRoute: NavigateRoute.initialRoute(),
    );
  }
}
