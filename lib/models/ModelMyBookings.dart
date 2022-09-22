class ModelMyBookings {
  bool? status;
  String? message;
  List<ModelBookingData>? data;

  ModelMyBookings({this.status, this.message, this.data});

  ModelMyBookings.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ModelBookingData>[];
      json['data'].forEach((v) {
        data!.add(new ModelBookingData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ModelBookingData {
  int? bookingId;
  String? allDay;
  String? customer;
  String? start;
  dynamic orderId;
  String? end;
  String? product;
  String? image;
  String? status;
  String? cost;
  bool? hasSuborder;
  List<PersonCounts>? personCounts;

  ModelBookingData(
      {this.bookingId,
      this.allDay,
      this.orderId,
      this.customer,
      this.start,
      this.end,
      this.image,
      this.product,
      this.status,
      this.cost,
      this.personCounts,
      this.hasSuborder});

  ModelBookingData.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'];
    orderId = json['order_id'];
    allDay = json['all_day'];
    customer = json['customer'];
    start = json['start'];
    end = json['end'];
    product = json['product'];
    status = json['status'];
    cost = json['cost'];
    image = json['image'];
    hasSuborder = json['has_suborder'];
    if (json['person_counts'] != null) {
      personCounts = <PersonCounts>[];
      json['person_counts'].forEach((v) {
        personCounts!.add(new PersonCounts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booking_id'] = bookingId;
    data['all_day'] = allDay;
    data['customer'] = customer;
    data['order_id'] = orderId;
    data['start'] = start;
    data['end'] = end;
    data['image'] = image;
    data['product'] = product;
    data['status'] = status;
    data['cost'] = cost;
    data['has_suborder'] = hasSuborder;
    if (personCounts != null) {
      data['person_counts'] = personCounts!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = title;
    data['value'] = value;
    return data;
  }
}
