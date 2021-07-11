import 'package:murarkey_app/custom_views/CustomStatefulWidget.dart';
import 'package:murarkey_app/custom_views/account_list/AcountListWidget.dart';
import 'package:murarkey_app/custom_views/account_profile/AccountProfileWidget.dart';
import 'package:murarkey_app/custom_views/fb_float_button/FBFloatingButton.dart';
import 'package:murarkey_app/repository/local/AccountDatas.dart';
import 'package:murarkey_app/routes/NavigateRoute.dart';
import 'package:murarkey_app/utils/Commons.dart';
import 'package:murarkey_app/utils/Imports.dart';

class AccountFragmentWidget extends StatefulWidget {
  @override
  _AccountFragmentWidgetState createState() => _AccountFragmentWidgetState();
}

class _AccountFragmentWidgetState
    extends CustomStatefulWidgetState<AccountFragmentWidget> {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    onTapGridItem(model, index) {
      if (index == 0) {
        print(model);
      } else if (index == 0) {
        Commons.toastMessage(context, "Comming soon");
      } else if (index == 1) {
        NavigateRoute.pushNamed(context, NavigateRoute.ADDRESS_Edit);
      } else if (index == 2) {
        NavigateRoute.pushNamed(context, NavigateRoute.MY_WALLET);
      } else if (index == 3) {
        Commons.toastMessage(context, "Comming soon");
      } else if (index == 4) {
        NavigateRoute.popAndPushNamed(context, NavigateRoute.LOGIN);
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
                        model: GlobalData.userModel,
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
        childWidget: builder(), floatingActionButton: FBFloatingButton().fab());
    //return render(childWidget: builder());
  }
}
