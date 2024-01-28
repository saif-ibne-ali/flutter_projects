class Profile {
  int? id;
  String? firstName;
  String? lastName;
  String? mobile;
  String? city;
  String? shippingAddress;
  String? email;
  String? createdAt;
  String? updatedAt;

  Profile(
      {this.id,
      this.firstName,
      this.lastName,
      this.mobile,
      this.city,
      this.shippingAddress,
      this.email,
      this.createdAt,
      this.updatedAt});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    mobile = json['mobile'];
    city = json['city'];
    shippingAddress = json['shippingAddress'];
    email = json['email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> profileData = <String, dynamic>{};
    profileData['id'] = id;
    profileData['firstName'] = firstName;
    profileData['lastName'] = lastName;
    profileData['mobile'] = mobile;
    profileData['city'] = city;
    profileData['shippingAddress'] = shippingAddress;
    profileData['email'] = email;
    profileData['created_at'] = createdAt;
    profileData['updated_at'] = updatedAt;
    return profileData;
  }
}
