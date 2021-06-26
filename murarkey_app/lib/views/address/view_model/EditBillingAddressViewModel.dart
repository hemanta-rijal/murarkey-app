import 'package:murarkey_app/repository/Repository.dart';
import 'package:murarkey_app/repository/api_call/ApiUrls.dart';
import 'package:murarkey_app/repository/models/country_list/CountryModel.dart';
import 'package:murarkey_app/utils/Commons.dart';
import 'package:murarkey_app/utils/Imports.dart';
import 'package:murarkey_app/utils/Validation.dart';

/**
 * Created by Suman Prasad Neupane on 5/20/2021.
 */

class EditBillingAddressViewModel {
  Repository _repository = new Repository();

  final TextEditingController formSpecificAddress = new TextEditingController();
  final TextEditingController formCity = new TextEditingController();
  final TextEditingController formZipCode = new TextEditingController();
  final TextEditingController formStateOrZone = new TextEditingController();
  CountryModel formCountry;

  _buildParams() {
    Map<String, dynamic> params = new Map();
    params["country"] = formCountry.name.trim();
    params["state"] = formStateOrZone.text.trim();
    params["city"] = formCity.text.toString(); //json.encode(viewModel.values);
    params["specific_address"] = formSpecificAddress.text.trim();
    params["zip"] = formZipCode.text.trim();
    return params;
  }

  _validate(BuildContext context) {
    if (formCountry == null || formCountry == "") {
      Commons.toastMessage(context, "Please select your country");
    } else if (formCity.text == null || formCity.text == "") {
      Commons.toastMessage(context, "Please enter city name");
    } else if (formStateOrZone.text == null || formStateOrZone.text == "") {
      Commons.toastMessage(context, "Please enter state or zone name");
    }
    else if (formZipCode.text == null || formZipCode.text == "") {
      Commons.toastMessage(context, "Please enter zip code");
    }
    else if (formSpecificAddress.text == null ||
        formSpecificAddress.text == "") {
      Commons.toastMessage(context, "Please enter specific address");
    } else {
      return true;
    }

    return false;
  }

  updateBillingAddress(BuildContext context) async {
    if (!_validate(context)) {
      return;
    }

    await _repository.paymentCardAddressApi
        .updateBillingAddress(
            url: ApiUrls.PAYMENT_BILLING_ADDRESS, params: _buildParams())
        .then((value) => {
              if (value != null)
                {
                  Commons.toastMessage(context, value["message"]),
                  _refreshUserDetails()
                }
              else
                {
                  Commons.toastMessage(
                      context, "Failed to update billing address."),
                }
            });
  }

  updateShippingAddress(BuildContext context) async {
    if (!_validate(context)) {
      return;
    }

    await _repository.paymentCardAddressApi
        .updateBillingAddress(
            url: ApiUrls.PAYMENT_SHIPPING_ADDRESS, params: _buildParams())
        .then((value) => {
              if (value != null)
                {
                  Commons.toastMessage(context, value["message"]),
                  _refreshUserDetails()
                }
              else
                {
                  Commons.toastMessage(
                      context, "Failed to update shipping address."),
                }
            });
  }

  _refreshUserDetails() async {
    await _repository.userApiRequest
        .getMyDetails(url: ApiUrls.ABOUT_ME)
        .then((value) => {
              if (value != null)
                {
                  GlobalData.userModel = value,
                  print(GlobalData.userModel.name),
                }
            });
  }
}
