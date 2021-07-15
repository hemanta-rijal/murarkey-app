import 'package:json_annotation/json_annotation.dart';
import 'package:murarkey_app/repository/models/payment_card_address/PaymentCardAddresModel.dart';

part 'WalletModel.g.dart';

/**
 * Created by Suman Prasad Neupane on 7/13/2021.
 */

@JsonSerializable(nullable: false)
class WalletModel{
  var user_id;
  var transaction_type;
  var payment_method;
  var amount;
  var status;
  var total_amount;
  var loadedOn;
  Remarks remarks;

  WalletModel({
    this.user_id,
    this.transaction_type,
    this.payment_method,
    this.amount,
    this.status,
    this.total_amount,
    this.loadedOn,
    this.remarks,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) =>
      _$WalletModelFromJson(json);

  Map<String, dynamic> toJson() => _$WalletModelToJson(this);
}

@JsonSerializable(nullable: false)
class Remarks{
  var logo;
  var text;

  Remarks({
    this.logo,
    this.text,
  });

  factory Remarks.fromJson(Map<String, dynamic> json) =>
      _$RemarksFromJson(json);

  Map<String, dynamic> toJson() => _$RemarksToJson(this);
}
