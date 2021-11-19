import 'package:murarkey_app/repository/Repository.dart';
import 'package:murarkey_app/repository/api_call/ApiUrls.dart';
import 'package:murarkey_app/repository/models/our_services/service_category_lists/ServicesCategoryListsModel.dart';
import 'package:murarkey_app/repository/models/popular_parlor/ParlorModel.dart';
import 'package:murarkey_app/utils/Commons.dart';
import 'package:murarkey_app/utils/Imports.dart';

class PopularParloursDetailController {
  Repository _repository = new Repository();
  ParlorModel parlorModel;

  Future<ParlorModel> getParloursDetail(int id) async {
    return await _repository.parlorApiRequest.getParlorDetails(
      url: ApiUrls.PARLOR_DETAIL_URL + "${id}",
    );
  }

  addToCartToServer(state, BuildContext context, ServicesCategoryListsModel model) async {
    //Add service
    Map<String, dynamic> params = new Map();
    params["product_id"] = model.id.toString();
    params["qty"] = 1.toString();

    params["type"] = "service";
    params["options"] = {
      "image": model.featured_image,
      "product_type": "service"
    };

    print(params);

    await _repository.productRequestApi
        .addToCard(url: ApiUrls.CART, params: params)
        .then((value) {
      if (value != null) {
        Commons.toastMessage(context, value["message"]);
      }
      state.setState(() {});
    });
  }
}
