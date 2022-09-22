class ModelLogIn {
  ModelLogIn({
    required this.status,
    required this.message,
    required this.data,
  });
  var status;
  var message;
  ModelLogInData? data;
  
  ModelLogIn.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    if(json['status']==true){
    data = ModelLogInData.fromJson(json['data']);
    }

  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['data'] = data!.toJson();
    return _data;
  }
}

class ModelLogInData {
  ModelLogInData({
    this.cookie,
    this.cookieAdmin,
    this.cookieName,
    this.user,
  });
  var cookie;
  var cookieAdmin;
  var cookieName;
  User? user;
  
  ModelLogInData.fromJson(Map<String, dynamic> json){
    cookie = json['cookie'];
    cookieAdmin = json['cookie_admin'];
    cookieName = json['cookie_name'];
    user = User.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['cookie'] = cookie;
    _data['cookie_admin'] = cookieAdmin;
    _data['cookie_name'] = cookieName;
    _data['user'] = user!.toJson();
    return _data;
  }
}

class User {
  User({
    required this.id,
    required this.username,
    required this.nicename,
    required this.email,
    required this.url,
    required this.registered,
    required this.displayname,
    required this.firstname,
    required this.lastname,
    required this.nickname,
    required this.description,
    required this.capabilities,
    required this.avatar,
  });
  var id;
  var username;
  var nicename;
  var email;
  var url;
  var registered;
  var displayname;
  var firstname;
  var lastname;
  var nickname;
  var description;
  var capabilities;
  var avatar;

  User.fromJson(Map<String, dynamic> json){
    id = json['id'];
    username = json['username'];
    nicename = json['nicename'];
    email = json['email'];
    url = json['url'];
    registered = json['registered'];
    displayname = json['displayname'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    nickname = json['nickname'];
    description = json['description'];
    capabilities = json['capabilities'];
    avatar = json['avatar'] == null ? '':json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['username'] = username;
    _data['nicename'] = nicename;
    _data['email'] = email;
    _data['url'] = url;
    _data['registered'] = registered;
    _data['displayname'] = displayname;
    _data['firstname'] = firstname;
    _data['lastname'] = lastname;
    _data['nickname'] = nickname;
    _data['description'] = description;
    _data['capabilities'] = capabilities;
    _data['avatar'] = avatar;
    return _data;
  }
}
