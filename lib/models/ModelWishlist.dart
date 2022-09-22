import 'package:dinelah/models/PopularProduct.dart';

class ModelWishListData {
  ModelWishListData({
    this.status,
    this.message,
    this.data,
  });
  bool? status;
  String? message;
  List<ModelProduct>? data;

  ModelWishListData.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    data = List.from(json['data']).map((e)=>ModelProduct.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['data'] = data!.map((e)=>e.toJson()).toList();
    return _data;
  }
}