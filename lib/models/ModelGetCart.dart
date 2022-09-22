import 'package:dinelah/models/PopularProduct.dart';

class ModelGetCartData {
  ModelGetCartData({
    this.status,
    this.message,
    this.data,
  });
  bool? status;
  String? message;
  Data? data;

  ModelGetCartData.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['data'] = data!.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.cartmeta,
    required this.items,
  });
  late final Cartmeta cartmeta;
  late final List<Items> items;

  Data.fromJson(Map<String, dynamic> json){
    cartmeta = Cartmeta.fromJson(json['cartmeta']);
    items = List.from(json['items']).map((e)=>Items.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['cartmeta'] = cartmeta.toJson();
    _data['items'] = items.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Cartmeta {
  Cartmeta({
    required this.subtotal,
    required this.subtotalTax,
    required this.shippingTotal,
    required this.shippingTax,
    required this.shippingTaxes,
    required this.discountTotal,
    required this.discountTax,
    required this.cartContentsTotal,
    required this.cartContentsTax,
    required this.cartContentsTaxes,
    required this.feeTotal,
    required this.feeTax,
    required this.feeTaxes,
    required this.total,
    required this.totalTax,
    required this.currencySymbol,
  });
  late final String subtotal;
  late final String subtotalTax;
  late final String shippingTotal;
  late final String shippingTax;
  late final List<dynamic> shippingTaxes;
  late final String discountTotal;
  late final String discountTax;
  late final String cartContentsTotal;
  late final String cartContentsTax;
  late final List<dynamic> cartContentsTaxes;
  late final String feeTotal;
  late final String feeTax;
  late final List<dynamic> feeTaxes;
  late final String total;
  late final String totalTax;
  late final String currencySymbol;

  Cartmeta.fromJson(Map<String, dynamic> json){
    subtotal = json['subtotal'];
    subtotalTax = json['subtotal_tax'];
    shippingTotal = json['shipping_total'];
    shippingTax = json['shipping_tax'];
    shippingTaxes = List.castFrom<dynamic, dynamic>(json['shipping_taxes']);
    discountTotal = json['discount_total'];
    discountTax = json['discount_tax'];
    cartContentsTotal = json['cart_contents_total'];
    cartContentsTax = json['cart_contents_tax'];
    cartContentsTaxes = List.castFrom<dynamic, dynamic>(json['cart_contents_taxes']);
    feeTotal = json['fee_total'];
    feeTax = json['fee_tax'];
    feeTaxes = List.castFrom<dynamic, dynamic>(json['fee_taxes']);
    total = json['total'];
    totalTax = json['total_tax'];
    currencySymbol = json['currency_symbol'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['subtotal'] = subtotal;
    _data['subtotal_tax'] = subtotalTax;
    _data['shipping_total'] = shippingTotal;
    _data['shipping_tax'] = shippingTax;
    _data['shipping_taxes'] = shippingTaxes;
    _data['discount_total'] = discountTotal;
    _data['discount_tax'] = discountTax;
    _data['cart_contents_total'] = cartContentsTotal;
    _data['cart_contents_tax'] = cartContentsTax;
    _data['cart_contents_taxes'] = cartContentsTaxes;
    _data['fee_total'] = feeTotal;
    _data['fee_tax'] = feeTax;
    _data['fee_taxes'] = feeTaxes;
    _data['total'] = total;
    _data['total_tax'] = totalTax;
    _data['currency_symbol'] = currencySymbol;
    return _data;
  }
}

class Items {
  Items({
    required this.product,
    required this.quantity,
    this.variation,
    this.addons,
  });
   ModelProduct? product;
   var quantity;
   var variation;
   var addons;

  Items.fromJson(Map<String, dynamic> json){
    product = ModelProduct.fromJson(json['product']);
    quantity = json['quantity'];
    variation = null;
    addons = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['product'] = product!.toJson();
    _data['quantity'] = quantity;
    _data['variation'] = variation;
    _data['addons'] = addons;
    return _data;
  }
}
