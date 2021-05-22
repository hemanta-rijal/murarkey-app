import 'package:murarkey_app/custom_views/CustomStatefulWidget.dart';
import 'package:murarkey_app/custom_views/text_view/TextFieldWidget.dart';
import 'package:murarkey_app/custom_views/text_view/TextviewWidget.dart';
import 'package:murarkey_app/routes/NavigateRoute.dart';
import 'package:murarkey_app/utils/Imports.dart';
import 'package:murarkey_app/views/address/view_model/EditAddressViewModel.dart';

/**
 * Created by Suman Prasad Neupane on 5/20/2021.
 */

class EditAddressWidget extends StatefulWidget {
  @override
  _EditAddressWidgetState createState() => _EditAddressWidgetState();
}

class _EditAddressWidgetState
    extends CustomStatefulWidgetState<EditAddressWidget> {
  EditAddressViewModel viewModel = new EditAddressViewModel();

  @override
  Widget build(BuildContext context) {
    super.build(context);

    Widget addressForm({String title, String name, Function(String) callback}) {
      return Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 24, bottom: 24, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 5,
                    child: textView1(
                        title: title,
                        textSize: 2.2,
                        fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    flex: 1,
                    child: InkResponse(
                      child: Container(
                        //padding: EdgeInsets.only(left: 8),
                        child: textView1(
                            title: "Edit",
                            textSize: 1.8,
                            fontWeight: FontWeight.bold,
                            textAlign: TextAlign.center,
                            color: AppConstants.appColor.accentColor),
                      ),
                      onTap: () {
                        callback(title);
                      },
                    ),
                  ),
                ],
              ),
              //First Name
              textView1(title: name, margin: EdgeInsets.only(top: 8)),
            ],
          ),
        ),
      );
    }

    void redirect(String type) {
      if (type == viewModel.Billing_Address) {
        NavigateRoute.pushNamed(context, NavigateRoute.ADDRESS_BILLING_Edit);
      }
      if (type == viewModel.Shipping_Address) {
        NavigateRoute.pushNamed(context, NavigateRoute.ADDRESS_SHIPPING_Edit);
      }
    }

    Widget buildView() {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 16,
        ),
        addressForm(
            title: viewModel.Billing_Address,
            name: "Ram Prasad Sitaula",
            callback: (type) {
              redirect(type);
            }),
        SizedBox(
          height: 16,
        ),
        addressForm(
            title: viewModel.Shipping_Address,
            name: "Ram Prasad Sitaula",
            callback: (type) {
              redirect(type);
            }),
      ]);
    }

    return renderWithAppBar(
        appBarText: "Edit Address", childWidget: buildView());
  }
}
