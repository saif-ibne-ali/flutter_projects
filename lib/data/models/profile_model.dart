import 'package:crafty_bay/data/models/user_model.dart';

class ProfileModel {
  int? id;
  String? cusName;
  String? cusAdd;
  String? cusCity;
  String? cusState;
  String? cusPostcode;
  String? cusCountry;
  String? cusPhone;
  String? cusFax;
  String? shipName;
  String? shipAdd;
  String? shipCity;
  String? shipState;
  String? shipPostcode;
  String? shipCountry;
  String? shipPhone;
  int? userId;
  String? createdAt;
  String? updatedAt;
  UserModel? user;

  ProfileModel(
      {this.id,
      this.cusName,
      this.cusAdd,
      this.cusCity,
      this.cusState,
      this.cusPostcode,
      this.cusCountry,
      this.cusPhone,
      this.cusFax,
      this.shipName,
      this.shipAdd,
      this.shipCity,
      this.shipState,
      this.shipPostcode,
      this.shipCountry,
      this.shipPhone,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.user});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] is String ? int.tryParse(json['id']) : json['id'];
    cusName = json['cus_name'];
    cusAdd = json['cus_add'];
    cusCity = json['cus_city'];
    cusState = json['cus_state'];
    cusPostcode = json['cus_postcode'];
    cusCountry = json['cus_country'];
    cusPhone = json['cus_phone'];
    cusFax = json['cus_fax'];
    shipName = json['ship_name'];
    shipAdd = json['ship_add'];
    shipCity = json['ship_city'];
    shipState = json['ship_state'];
    shipPostcode = json['ship_postcode'];
    shipCountry = json['ship_country'];
    shipPhone = json['ship_phone'];
    userId = json['user_id'] is String
        ? int.tryParse(json['user_id'])
        : json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    if (cusName != null) data['cus_name'] = cusName;
    if (cusAdd != null) data['cus_add'] = cusAdd;
    if (cusCity != null) data['cus_city'] = cusCity;
    if (cusState != null) data['cus_state'] = cusState;
    if (cusPostcode != null) data['cus_postcode'] = cusPostcode;
    if (cusCountry != null) data['cus_country'] = cusCountry;
    if (cusPhone != null) data['cus_phone'] = cusPhone;
    if (cusFax != null) data['cus_fax'] = cusFax;
    if (shipName != null) data['ship_name'] = shipName;
    if (shipAdd != null) data['ship_add'] = shipAdd;
    if (shipCity != null) data['ship_city'] = shipCity;
    if (shipState != null) data['ship_state'] = shipState;
    if (shipPostcode != null) data['ship_postcode'] = shipPostcode;
    if (shipCountry != null) data['ship_country'] = shipCountry;
    if (shipPhone != null) data['ship_phone'] = shipPhone;
    if (userId != null) data['user_id'] = userId;
    if (createdAt != null) data['created_at'] = createdAt;
    if (updatedAt != null) data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
