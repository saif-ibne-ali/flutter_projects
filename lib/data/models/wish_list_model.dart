import 'package:crafty_bay/data/models/wish_item.dart';

class WishListModel {
  String? msg;
  List<WishItem>? wishItemList;

  WishListModel({this.msg, this.wishItemList});

  WishListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      wishItemList = <WishItem>[];
      json['data'].forEach((v) {
        wishItemList!.add(WishItem.fromJson(v));
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



