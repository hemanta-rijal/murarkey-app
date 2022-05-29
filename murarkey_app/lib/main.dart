import 'package:murarkey_app/routes/NavigateRoute.dart';
import 'package:murarkey_app/utils/Imports.dart';
import 'package:murarkey_app/views/auth/register/RegisterWidget.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.constants.APP_NAME,
      theme: AppConstants.appTheme.buildTheme(),
      onGenerateRoute: NavigateRoute.generateRoute,
      initialRoute: NavigateRoute.initialRoute(),
    );
  }
}

/**
 * Created by Suman Prasad Neupane on 6/12/2021.
 * https://stackoverflow.com/questions/53503644/map-a-json-string-into-an-item-model-in-flutter
 * flutter clean && flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs
 * flutter clean; flutter pub get; flutter pub run build_runner build --delete-conflicting-outputs
 */
