class ModelSingleOrderData {
  ModelSingleOrderData({
    this.status,
    this.message,
    this.data,
  });
  dynamic status;
  dynamic message;
  Data? data;

  ModelSingleOrderData.fromJson(Map<String, dynamic> json) {
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
    required this.deliveryDetail,
    required this.storeInformation,
    required this.orderData,
    required this.hasSuborder,
    required this.suborderData,
  });
  DeliveryDetail? deliveryDetail;
  late final DeliveryDetail storeInformation;
  late final OrderData orderData;
  late final bool hasSuborder;
  late final List<SuborderData> suborderData;

  Data.fromJson(Map<String, dynamic> json) {
    deliveryDetail = json['delivery_detail'] == null
        ? null
        : DeliveryDetail.fromJson(json['delivery_detail']);
    storeInformation =
        DeliveryDetail.fromJson(json['store_information']);
    orderData = OrderData.fromJson(json['order_data']);
    hasSuborder = json['has_suborder'];
    suborderData = List.from(json['suborder_data'])
        .map((e) => SuborderData.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['delivery_detail'] = deliveryDetail!.toJson();
    _data['store_information'] = storeInformation.toJson();
    _data['order_data'] = orderData.toJson();
    _data['has_suborder'] = hasSuborder;
    _data['suborder_data'] = suborderData.map((e) => e.toJson()).toList();
    return _data;
  }
}

class DeliveryDetail {
  DeliveryDetail({
    required this.id,
    required this.name,
    required this.image,
    required this.phone,
    required this.address,
  });
  late final String id;
  late final String name;
  late final String image;
  late final String phone;
  late final String address;

  DeliveryDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    phone = json['phone'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['image'] = image;
    _data['phone'] = phone;
    _data['address'] = address;
    return _data;
  }
}

class ModelStoreInformation {
  ModelStoreInformation({
    required this.id,
    required this.name,
    required this.image,
    required this.phone,
    required this.address,
    required this.storeName,
  });
  dynamic id;
  dynamic name;
  dynamic image;
  dynamic phone;
  dynamic address;
  dynamic storeName;

  ModelStoreInformation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    phone = json['phone'];
    address = json['address'];
    storeName = json['store_name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['image'] = image;
    _data['phone'] = phone;
    _data['address'] = address;
    _data['store_name'] = storeName;
    return _data;
  }
}

class OrderData {
  OrderData({
    required this.id,
    required this.status,
    required this.dateCreated,
    required this.shippingTotal,
    required this.totalTax,
    required this.discountTotal,
    required this.total,
    required this.currencySymbol,
    required this.paymentMethodTitle,
    required this.lineItems,
  });
  late final int id;
  late final String status;
  late final String dateCreated;
  late final String shippingTotal;
  late final String totalTax;
  late final String discountTotal;
  late final String total;
  late final String currencySymbol;
  late final String paymentMethodTitle;
  late final List<LineItems> lineItems;

  OrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    dateCreated = json['date_created'];
    shippingTotal = json['shipping_total'];
    totalTax = json['total_tax'];
    discountTotal = json['discount_total'];
    total = json['total'];
    currencySymbol = json['currency_symbol'];
    paymentMethodTitle = json['payment_method_title'];
    lineItems = List.from(json['line_items'])
        .map((e) => LineItems.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['status'] = status;
    _data['date_created'] = dateCreated;
    _data['shipping_total'] = shippingTotal;
    _data['total_tax'] = totalTax;
    _data['discount_total'] = discountTotal;
    _data['total'] = total;
    _data['currency_symbol'] = currencySymbol;
    _data['payment_method_title'] = paymentMethodTitle;
    _data['line_items'] = lineItems.map((e) => e.toJson()).toList();
    return _data;
  }
}

class LineItems {
  LineItems({
    required this.id,
    required this.name,
    required this.productId,
    required this.variationId,
    required this.quantity,
    required this.total,
    required this.currencySymbol,
  });
  late final int id;
  late final String name;
  late final int productId;
  late final int variationId;
  late final int quantity;
  late final String total;
  late final String currencySymbol;

  LineItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    productId = json['product_id'];
    variationId = json['variation_id'];
    quantity = json['quantity'];
    total = json['total'];
    currencySymbol = json['currency_symbol'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['product_id'] = productId;
    _data['variation_id'] = variationId;
    _data['quantity'] = quantity;
    _data['total'] = total;
    _data['currency_symbol'] = currencySymbol;
    return _data;
  }
}

class SuborderData {
  SuborderData({
    required this.orderId,
    required this.products,
  });
  late final int orderId;
  late final List<Products> products;

  SuborderData.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    products =
        List.from(json['products']).map((e) => Products.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['order_id'] = orderId;
    _data['products'] = products.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Products {
  Products({
    required this.id,
    required this.productImage,
    required this.productName,
    required this.productQty,
  });
  late final int id;
  late final String productImage;
  late final String productName;
  late final int productQty;

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productImage = json['product_image'];
    productName = json['product_name'];
    productQty = json['product_qty'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['product_image'] = productImage;
    _data['product_name'] = productName;
    _data['product_qty'] = productQty;
    return _data;
  }
}
