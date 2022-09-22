class ModelGetAddresss {
  ModelGetAddresss({
    this.status,
    this.message,
    this.data,
  });
   bool? status;
   String? message;
   Data? data;

  ModelGetAddresss.fromJson(Map<String, dynamic> json){
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
    required this.billingAddress,
    required this.shippingAddress,
  });
  late final BillingAddress billingAddress;
  late final ShippingAddress shippingAddress;

  Data.fromJson(Map<String, dynamic> json){
    billingAddress = BillingAddress.fromJson(json['billing_address']);
    shippingAddress = ShippingAddress.fromJson(json['shipping_address']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['billing_address'] = billingAddress.toJson();
    _data['shipping_address'] = shippingAddress.toJson();
    return _data;
  }
}

class BillingAddress {
  BillingAddress({
    required this.billingFirstName,
    required this.billingLastName,
    required this.billingAddress_1,
    required this.billingAddress_2,
    required this.billingCity,
    required this.billingPostcode,
    required this.billingCountry,
    required this.billingState,
    required this.billingPhone,
    required this.billingEmail,
  });
   var billingFirstName;
   var billingLastName;
   var billingAddress_1;
   var billingAddress_2;
   var billingCity;
   var billingPostcode;
   var billingCountry;
   var billingState;
   var billingPhone;
   var billingEmail;

  BillingAddress.fromJson(Map<String, dynamic> json){
    billingFirstName = json['billing_first_name'];
    billingLastName = json['billing_last_name'];
    billingAddress_1 = json['billing_address_1'];
    billingAddress_2 = json['billing_address_2'];
    billingCity = json['billing_city'];
    billingPostcode = json['billing_postcode'];
    billingCountry = json['billing_country'];
    billingState = json['billing_state'];
    billingPhone = json['billing_phone'];
    billingEmail = json['billing_email'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['billing_first_name'] = billingFirstName;
    _data['billing_last_name'] = billingLastName;
    _data['billing_address_1'] = billingAddress_1;
    _data['billing_address_2'] = billingAddress_2;
    _data['billing_city'] = billingCity;
    _data['billing_postcode'] = billingPostcode;
    _data['billing_country'] = billingCountry;
    _data['billing_state'] = billingState;
    _data['billing_phone'] = billingPhone;
    _data['billing_email'] = billingEmail;
    return _data;
  }
}

class ShippingAddress {
  ShippingAddress({
    required this.shippingFirstName,
    required this.shippingLastName,
    required this.shippingAddress_1,
    required this.shippingAddress_2,
    required this.shippingCity,
    required this.shippingPostcode,
    required this.shippingCountry,
    required this.shippingState,
    required this.shippingPhone,
    required this.shippingEmail,
  });
  var shippingFirstName;
  var shippingLastName;
  var shippingAddress_1;
  var shippingAddress_2;
  var shippingCity;
  var shippingPostcode;
  var shippingCountry;
  var shippingState;
  var shippingPhone;
  var shippingEmail;

  ShippingAddress.fromJson(Map<String, dynamic> json){
    shippingFirstName = json['shipping_first_name'];
    shippingLastName = json['shipping_last_name'];
    shippingAddress_1 = json['shipping_address_1'];
    shippingAddress_2 = json['shipping_address_2'];
    shippingCity = json['shipping_city'];
    shippingPostcode = json['shipping_postcode'];
    shippingCountry = json['shipping_country'];
    shippingState = json['shipping_state'];
    shippingPhone = json['shipping_phone'];
    shippingEmail = json['shipping_email'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['shipping_first_name'] = shippingFirstName;
    _data['shipping_last_name'] = shippingLastName;
    _data['shipping_address_1'] = shippingAddress_1;
    _data['shipping_address_2'] = shippingAddress_2;
    _data['shipping_city'] = shippingCity;
    _data['shipping_postcode'] = shippingPostcode;
    _data['shipping_country'] = shippingCountry;
    _data['shipping_state'] = shippingState;
    _data['shipping_phone'] = shippingPhone;
    _data['shipping_email'] = shippingEmail;
    return _data;
  }
}