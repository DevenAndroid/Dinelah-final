class ModelGetOrdersData {
  ModelGetOrdersData({
    this.status,
    this.message,
    this.data,
  });
  dynamic status;
  dynamic message;
  Data? data;

  ModelGetOrdersData.fromJson(Map<String, dynamic> json) {
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
    required this.count,
    required this.page,
    required this.perPage,
    required this.orders,
  });
  late final int count;
  late final int page;
  late final int perPage;
  late final List<Orders> orders;

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    page = json['page'];
    perPage = json['per_page'];
    orders = List.from(json['orders']).map((e) => Orders.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['count'] = count;
    _data['page'] = page;
    _data['per_page'] = perPage;
    _data['orders'] = orders.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Orders {
  Orders({
    required this.id,
    required this.parentId,
    required this.status,
    required this.currency,
    required this.version,
    required this.pricesIncludeTax,
    required this.dateCreated,
    required this.dateModified,
    required this.discountTotal,
    required this.discountTax,
    required this.shippingTotal,
    required this.shippingTax,
    required this.cartTax,
    required this.total,
    required this.totalTax,
    required this.customerId,
    required this.orderKey,
    required this.paymentMethod,
    required this.paymentMethodTitle,
    required this.transactionId,
    required this.customerIpAddress,
    required this.createdVia,
    required this.customerNote,
    this.dateCompleted,
    this.datePaid,
    required this.cartHash,
    required this.number,
    required this.dateCreatedGmt,
    required this.dateModifiedGmt,
    this.dateCompletedGmt,
    this.datePaidGmt,
    required this.image,
    required this.currencySymbol,
    required this.hasSuborder,
  });
  late final int id;
  late final int parentId;
  late final String status;
  late final String currency;
  late final String version;
  late final bool pricesIncludeTax;
  late final String dateCreated;
  late final String dateModified;
  late final String discountTotal;
  late final String discountTax;
  late final String shippingTotal;
  late final String shippingTax;
  late final String cartTax;
  late final String total;
  late final String totalTax;
  late final int customerId;
  late final String orderKey;
  late final String paymentMethod;
  late final String paymentMethodTitle;
  late final String transactionId;
  late final String customerIpAddress;
  late final String createdVia;
  late final String customerNote;
  late final Null dateCompleted;
  late final Null datePaid;
  late final String cartHash;
  late final String number;
  late final String dateCreatedGmt;
  late final String dateModifiedGmt;
  late final Null dateCompletedGmt;
  late final Null datePaidGmt;
  late final String image;
  late final String currencySymbol;
  late final bool hasSuborder;

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    status = json['status'];
    currency = json['currency'];
    version = json['version'];
    pricesIncludeTax = json['prices_include_tax'];
    dateCreated = json['date_created'];
    dateModified = json['date_modified'];
    discountTotal = json['discount_total'];
    discountTax = json['discount_tax'];
    shippingTotal = json['shipping_total'];
    shippingTax = json['shipping_tax'];
    cartTax = json['cart_tax'];
    total = json['total'];
    totalTax = json['total_tax'];
    customerId = json['customer_id'];
    orderKey = json['order_key'];
    paymentMethod = json['payment_method'];
    paymentMethodTitle = json['payment_method_title'];
    transactionId = json['transaction_id'];
    customerIpAddress = json['customer_ip_address'];
    createdVia = json['created_via'];
    customerNote = json['customer_note'];
    dateCompleted = null;
    datePaid = null;
    cartHash = json['cart_hash'];
    number = json['number'];
    dateCreatedGmt = json['date_created_gmt'];
    dateModifiedGmt = json['date_modified_gmt'];
    dateCompletedGmt = null;
    datePaidGmt = null;
    image = json['image'];
    currencySymbol = json['currency_symbol'];
    hasSuborder = json['has_suborder'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['parent_id'] = parentId;
    _data['status'] = status;
    _data['currency'] = currency;
    _data['version'] = version;
    _data['prices_include_tax'] = pricesIncludeTax;
    _data['date_created'] = dateCreated;
    _data['date_modified'] = dateModified;
    _data['discount_total'] = discountTotal;
    _data['discount_tax'] = discountTax;
    _data['shipping_total'] = shippingTotal;
    _data['shipping_tax'] = shippingTax;
    _data['cart_tax'] = cartTax;
    _data['total'] = total;
    _data['total_tax'] = totalTax;
    _data['customer_id'] = customerId;
    _data['order_key'] = orderKey;
    _data['payment_method'] = paymentMethod;
    _data['payment_method_title'] = paymentMethodTitle;
    _data['transaction_id'] = transactionId;
    _data['customer_ip_address'] = customerIpAddress;
    _data['created_via'] = createdVia;
    _data['customer_note'] = customerNote;
    _data['date_completed'] = dateCompleted;
    _data['date_paid'] = datePaid;
    _data['cart_hash'] = cartHash;
    _data['number'] = number;
    _data['date_created_gmt'] = dateCreatedGmt;
    _data['date_modified_gmt'] = dateModifiedGmt;
    _data['date_completed_gmt'] = dateCompletedGmt;
    _data['date_paid_gmt'] = datePaidGmt;
    _data['image'] = image;
    _data['currency_symbol'] = currencySymbol;
    _data['has_suborder'] = hasSuborder;
    return _data;
  }
}
