import 'package:crafty_bay/data/models/wish_model.dart';

class WishListModel {
  String? msg;
  List<WishModel>? wishItemList;

  WishListModel({this.msg, this.wishItemList});

  WishListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      wishItemList = <WishModel>[];
      json['data'].forEach((v) {
        wishItemList!.add(WishModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    if (wishItemList != null) {
      data['data'] = wishItemList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



