import 'package:murarkey_app/utils/Imports.dart';

/**
 * Created by Suman Prasad Neupane on 5/17/2021.
 */

class AccountDatas{
  static var profileData = {
    "firstName": "Suamn",
    "lastName": "Neupane",
    "balance" : "4880.0",
    "imgUrl": "https://media.istockphoto.com/photos/portrait-of-adorable-young-happy-boy-picture-id158879321?k=6&m=158879321&s=612x612&w=0&h=_hskTiAyY6Z7kjC9ovEl6ND6PmBKroEEmeOr3d2t2MI=",
  };

  static var accountItemList = [
    {
      "name": "Recent Orders",
      "imgIcon": Icons.list_alt_sharp
    },
    {
      "name": "Edit Address",
      "imgIcon": Icons.location_on
    },
    {
      "name": "My Wallet",
      "imgIcon": Icons.account_balance_wallet
    },
    {
      "name": "Setting",
      "imgIcon": Icons.settings
    },
    {
      "name": "Logout",
      "imgIcon": Icons.logout
    }
  ];

  static var countryList =  ["Nepal", "India", "China"];

  static var zoneList =  ["Lumbini", "Gandakhi", "Koshi"];

  static var myMalletList = [
    {
      "sn": "1011",
      "date": "29,June-2021",
      "amount": "5000",
      "type": "Credit",
      "accumulated": "NRP. 5000",
      "remarks": "Loaded Successfully",
      "status": "success",
      "payment": "eSewa",
      "imageUrl": "http://newweb.murarkey.com/frontend/img/esewa.png"
    },
    {
      "sn": "1012",
      "date": "29,June-2021",
      "amount": "5000",
      "type": "Debit",
      "accumulated": "NRP. 5000",
      "remarks": "Loaded Successfully",
      "status": "success",
      "payment": "Wallet",
      "imageUrl": "http://newweb.murarkey.com/frontend/img/wallet.png"
    },
    {
      "sn": "1013",
      "date": "29,June-2021",
      "amount": "999.9",
      "type": "Credit",
      "accumulated": "NRP. 0",
      "remarks": "Loaded UnSuccessfully",
      "status": "Failure",
      "payment": "Wallet",
      "imageUrl": "http://newweb.murarkey.com/frontend/img/wallet.png"
    },
    {
      "sn": "1014",
      "date": "29,June-2021",
      "amount": "5000",
      "type": "Credit",
      "accumulated": "NRP. 5000",
      "remarks": "Loaded Successfully",
      "status": "success",
      "payment": "eSewa",
      "imageUrl": "http://newweb.murarkey.com/frontend/img/esewa.png"
    },
  ];
}