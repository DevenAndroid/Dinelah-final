class ModelVerifyOTPForgotPassword {
  bool? status;
  String? message;
  Data? data;

  ModelVerifyOTPForgotPassword({this.status, this.message, this.data});

  ModelVerifyOTPForgotPassword.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? cookie;
  String? cookieAdmin;

  Data({this.cookie, this.cookieAdmin});

  Data.fromJson(Map<String, dynamic> json) {
    cookie = json['cookie'];
    cookieAdmin = json['cookie_admin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cookie'] = cookie;
    data['cookie_admin'] = cookieAdmin;
    return data;
  }
}
