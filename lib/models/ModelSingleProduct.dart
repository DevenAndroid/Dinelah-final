import 'package:dinelah/models/PopularProduct.dart';

class ModelSingleProductData {
  ModelSingleProductData({
    this.status,
    this.message,
    this.popularProducts,
  });
  bool? status;
  String? message;
  List<ModelProduct>? popularProducts;

  ModelSingleProductData.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    popularProducts = List.from(json['data']).map((e)=>ModelProduct.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['data'] = popularProducts!.map((e)=>e.toJson()).toList();
    return _data;
  }
}