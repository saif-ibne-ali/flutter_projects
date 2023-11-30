class UserModel {
  String? email;
  String? firstName;
  String? lastName;
  String? mobile;
  String? photo;

  UserModel({this.email, this.firstName, this.lastName, this.mobile, this.photo});

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    mobile = json['mobile'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> user = <String, dynamic>{};
    user['email'] = email;
    user['firstName'] = firstName;
    user['lastName'] = lastName;
    user['mobile'] = mobile;
    user['photo'] = photo;
    return user;
  }
}
