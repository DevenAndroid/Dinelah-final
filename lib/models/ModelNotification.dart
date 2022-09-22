class ModelNotificationData {
  ModelNotificationData({
    this.status,
    this.message,
    this.data,
  });
  bool? status;
  String? message;
  Data? data;

  ModelNotificationData.fromJson(Map<String, dynamic> json) {
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
    required this.notifications,
  });
  late final int count;
  late final List<Notifications> notifications;

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    notifications = List.from(json['notifications'])
        .map((e) => Notifications.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['count'] = count;
    _data['notifications'] = notifications.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Notifications {
  Notifications({
    required this.date,
    required this.title,
    required this.orderId,
    required this.screenType,
    required this.description,
    required this.icon,
  });
  late final String date;
  late final String title;
  dynamic orderId;
  late final String screenType;
  late final String description;
  late final String icon;

  Notifications.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    title = json['title'];
    orderId = json['order_id'];
    screenType = json['screen_type'];
    description = json['description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['date'] = date;
    _data['title'] = title;
    _data['order_id'] = orderId;
    _data['screen_type'] = screenType;
    _data['description'] = description;
    _data['icon'] = icon;
    return _data;
  }
}
