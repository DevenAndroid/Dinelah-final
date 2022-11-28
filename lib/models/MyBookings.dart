  class ModelMyBookingsNew {
  bool? status;
  String? message;
  List<Data>? data;

  ModelMyBookingsNew({this.status, this.message, this.data});

  ModelMyBookingsNew.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? bookingId;
  bool? hasSuborder;
  int? orderId;
  String? allDay;
  String? customer;
  bool? customerCanCancel;
  String? start;
  String? end;
  String? product;
  String? storeAddress;
  String? image;
  String? status;
  String? cost;
  List<PersonCounts>? personCounts;

  Data(
      {this.bookingId,
      this.hasSuborder,
      this.orderId,
      this.allDay,
      this.customer,
      this.customerCanCancel,
      this.start,
      this.end,
      this.product,
      this.storeAddress,
      this.image,
      this.status,
      this.cost,
      this.personCounts});

  Data.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'];
    hasSuborder = json['has_suborder'];
    orderId = json['order_id'];
    allDay = json['all_day'];
    customer = json['customer'];
    customerCanCancel = json['customer_can_cancel'];
    start = json['start'];
    end = json['end'];
    product = json['product'];
    storeAddress = json['store_address'];
    image = json['image'];
    status = json['status'];
    cost = json['cost'];
    if (json['person_counts'] != null) {
      personCounts = <PersonCounts>[];
      json['person_counts'].forEach((v) {
        personCounts!.add(PersonCounts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['booking_id'] = bookingId;
    data['has_suborder'] = hasSuborder;
    data['order_id'] = orderId;
    data['all_day'] = allDay;
    data['customer'] = customer;
    data['customer_can_cancel'] = customerCanCancel;
    data['start'] = start;
    data['end'] = end;
    data['product'] = product;
    data['store_address'] = storeAddress;
    data['image'] = image;
    data['status'] = status;
    data['cost'] = cost;
    if (personCounts != null) {
      data['person_counts'] =
          personCounts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PersonCounts {
  String? title;
  int? value;

  PersonCounts({this.title, this.value});

  PersonCounts.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['value'] = value;
    return data;
  }
}
