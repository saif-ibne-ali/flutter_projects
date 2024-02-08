class Profile {
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

  Profile(
      {this.cusName,
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
        this.shipPhone});

  Profile.fromJson(Map<String, dynamic> json) {
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      "cus_name": cusName,
      "cus_add": cusAdd,
      "cus_city": cusCity,
      "cus_state": cusState,
      "cus_postcode": cusPostcode,
      "cus_country": cusCountry,
      "cus_phone": cusPhone,
      "cus_fax": cusFax,
      "ship_name": shipName,
      "ship_add": shipAdd,
      "ship_city": shipCity,
      "ship_state": shipState,
      "ship_postcode": shipPostcode,
      "ship_country": shipCountry,
      "ship_phone": shipPhone,
    };
    return data;
  }
}
