import 'package:murarkey_app/custom_views/CustomStatefulWidget.dart';
import 'package:murarkey_app/custom_views/UnauthorizedUserWidget.dart';
import 'package:murarkey_app/custom_views/account_list/AcountListWidget.dart';
import 'package:murarkey_app/custom_views/account_profile/AccountProfileWidget.dart';
import 'package:murarkey_app/custom_views/fb_float_button/FBFloatingButton.dart';
import 'package:murarkey_app/custom_views/loader/CustomAnimation.dart';
import 'package:murarkey_app/custom_views/network/ConnectivityWidget.dart';
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
  int walletAmount = 0;
  bool loginRequired;
  bool loading = false;
  bool hasNetworkConnectivity = true;

  redirectToLogin() {
    setState(() {
      loginRequired = true;
    });
  }

  @override
  void initState() {
    EasyLoadingView.show(message: 'Loading...');
    loadData();
    super.initState();
  }

  loadData() async {
    hasNetworkConnectivity = await Commons.checkNetworkConnectivity();
    if (!hasNetworkConnectivity) {
      loading = true;
      EasyLoadingView.dismiss();
      setState(() {});
      return;
    } else {
      try {
        walletAmount = await _repository.walletApiRequest.getWalletInfo(
          url: ApiUrls.GET_WALLET_INFO,
        );
      } catch (e) {
        walletAmount = 0;
      }
      loading = true;
      EasyLoadingView.dismiss();
      setState(() {});
      return;
    }
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
        EasyLoadingView.show(message: 'Logging out...');
        _repository.authApiRequest
            .logout(url: ApiUrls.LOGOUT_URL)
            .then((value) {
          EasyLoadingView.dismiss();
          if (value != null) {
            Commons.toastMessage(context, value["message"]);
            //redirectToLogin();
          } else {
            Commons.toastMessage(context, "Logout successfully");
            //redirectToLogin();
          }
          NavigateRoute.popAndPushNamed(
            context,
            NavigateRoute.LOGIN,
          );
        });
      }
    }

    onTapEditProfile() {
      NavigateRoute.pushNamed(context, NavigateRoute.PROFILE_Edit);
    }

    builder() {
      userModel = GlobalData.userModel;
      if (userModel.name == null) {
        loginRequired = true;
      } else {
        loginRequired = false;
      }

      if (loginRequired == null || !loading) {
        return Container();
      } else if (!hasNetworkConnectivity) {
        return Container(
          margin: EdgeInsets.only(top: 120),
          child: ConnectivityWidget(
            retry: () {
              hasNetworkConnectivity = true;
              loginRequired = null;
              loading = false;
              setState(() {});
              EasyLoadingView.show(message: 'Loading...');
              Future.delayed(Duration(seconds: 2), () {
                loadData();
              });
            },
          ),
        );
      } else if (hasNetworkConnectivity && loginRequired && loading) {
        return UnauthorizedUserWidget();
      }

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
                    child: Column(
                      children: [
                        AccountProfileWidget(
                          model: userModel,
                          walletAmount: walletAmount,
                          onTapCallback: () {
                            onTapEditProfile();
                          },
                        ),
                        AcountListWidget(
                          modelList: AccountDatas.accountItemList,
                          onTapGridItem: (model, index) {
                            onTapGridItem(model, index);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return render(
      childWidget: builder(),
      bodybackgroundColor: AppConstants.appColor.backgroundColor2,
      floatingActionButton: FBFloatingButton().fab(),
    );
    //return render(childWidget: builder());
  }
}
