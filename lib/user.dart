class User {
  String id;
  String email;
  String last_login;
  String last_logout;
  String is_active;
  String logged_in;
  String is_active_for_chat;
  String token;
  String ban_time;
  String ban_option;

  User(
      this.id,
      this.email,
      this.last_login,
      this.last_logout,
      this.is_active,
      this.logged_in,
      this.is_active_for_chat,
      this.token,
      this.ban_time,
      this.ban_option);

  User.map(dynamic obj) {
    this.id = obj["id"];
    this.email = obj["email"];
    this.last_login = obj["last_login"];
    this.last_logout = obj["last_logout"];
    this.is_active = obj["is_active"];
    this.logged_in = obj["logged_in"];
    this.is_active_for_chat = obj["is_active_for_chat"];
    this.token = obj["token"];
    this.ban_time = obj["ban_time"];
    this.ban_option = obj["ban_option"];
  }

  String get id1 => id;
  String get email1 => email;
  String get last_login1 => last_login;
  String get last_logout1 => last_logout;
  String get is_active1 => is_active;
  String get logged_in1 => logged_in;
  String get is_active_for_chat1 => is_active_for_chat;
  String get token1 => token;
  String get ban_time1 => ban_time;
  String get ban_option1 => ban_option;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["email"] = email;
    map["last_login"] = last_login;
    map["last_logout"] = last_logout;
    map["is_active"] = is_active;
    map["logged_in"] = logged_in;
    map["is_active_for_chat"] = is_active_for_chat;
    map["token"] = token;
    map["ban_time"] = ban_time;
    map["ban_option"] = ban_option;

    return map;
  }
}
