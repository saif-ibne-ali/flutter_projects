class CreateProfileParams {
  final String cusName;
  final String shipName;
  final String cusPhone;
  final String cusCity;
  final String cusAdd;

  CreateProfileParams(
      {required this.cusName,
      required this.shipName,
      required this.cusPhone,
      required this.cusCity,
      required this.cusAdd});

  Map<String, dynamic> toJson()  => {
    'firstName': cusName,
    'lastName': shipName,
    'mobile': cusPhone,
    'city': cusCity,
    'shippingAddress': cusAdd,
  };
}

