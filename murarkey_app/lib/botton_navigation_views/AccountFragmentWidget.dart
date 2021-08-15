import 'package:murarkey_app/custom_views/CustomStatefulWidget.dart';
import 'package:murarkey_app/custom_views/account_list/AcountListWidget.dart';
import 'package:murarkey_app/custom_views/account_profile/AccountProfileWidget.dart';
import 'package:murarkey_app/custom_views/fb_float_button/FBFloatingButton.dart';
import 'package:murarkey_app/repository/Repository.dart';
import 'package:murarkey_app/repository/api_call/ApiUrls.dart';
import 'package:murarkey_app/repository/local/AccountDatas.dart';
import 'package:murarkey_app/repository/models/user/UserModel.dart';
import 'package:murarkey_app/routes/NavigateRoute.dart';
import 'package:murarkey_app/utils/Commons.dart';
import 'package:murarkey_app/utils/Imports.dart';

class AccountFragmentWidget extends StatefulWidget {
  @override
  _AccountFragmentWidgetState createState() => _AccountFragmentWidgetState();
}

class _AccountFragmentWidgetState
    extends CustomStatefulWidgetState<AccountFragmentWidget> {
  Repository _repository = new Repository();
  UserModel userModel = GlobalData.userModel;

  @override
  void didChangeDependencies() {
    if (mounted) {
      userModel = GlobalData.userModel;
      setState(() {});
      if (userModel.name == null) {
        Future.delayed(const Duration(milliseconds: 500), () {
          setState(() {
            Commons.toastMessage(context, "Please Login to seen your account.");
            NavigateRoute.popAndPushNamed(context, NavigateRoute.LOGIN);
          });
        });
      }
    }
    super.didChangeDependencies();
  }

  redirectToLogin() {
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        NavigateRoute.popAndPushNamed(context, NavigateRoute.LOGIN);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    onTapGridItem(model, index) {
      if (index == 0) {
        NavigateRoute.pushNamed(context, NavigateRoute.RECENT_ORDER);
      } else if (index == 1) {
        NavigateRoute.pushNamed(context, NavigateRoute.ADDRESS_Edit);
      } else if (index == 2) {
        NavigateRoute.pushNamed(context, NavigateRoute.MY_WALLET);
      } else if (index == 3) {
        Commons.toastMessage(context, "Comming soon");
      } else if (index == 4) {
        _repository.authApiRequest
            .logout(url: ApiUrls.LOGOUT_URL)
            .then((value) {
          if (value != null) {
            Commons.toastMessage(context, value["message"]);
            redirectToLogin();
          } else {
            Commons.toastMessage(context, "Logout successfully");
            redirectToLogin();
          }
        });
      }
    }

    onTapEditProfile() {
      NavigateRoute.pushNamed(context, NavigateRoute.PROFILE_Edit);
    }

    builder() {
      return new LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: viewportConstraints.maxHeight),
            child: Stack(
              children: [
                Container(
                  height: 88,
                  color: AppConstants.appColor.primaryColor,
                ),
                //
                Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  child: Column(children: [
                    AccountProfileWidget(
                        model: userModel,
                        onTapCallback: () {
                          onTapEditProfile();
                        }),
                    AcountListWidget(
                        modelList: AccountDatas.accountItemList,
                        onTapGridItem: (model, index) {
                          onTapGridItem(model, index);
                        }),
                  ]),
                ),
              ],
            ),
          ),
        );
      });
    }

    return render(
      childWidget: builder(),
      bodybackgroundColor: AppConstants.appColor.backgroundColor2,
      floatingActionButton: FBFloatingButton().fab(),
    );
    //return render(childWidget: builder());
  }
}
