class ModelCartQuantity {
  ModelCartQuantity({
    this.status,
    this.message,
    this.quantity,
  });
  dynamic status;
  dynamic message;
  dynamic quantity;

  ModelCartQuantity.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['quantity'] = quantity;
    return _data;
  }
}
