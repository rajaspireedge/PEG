class Universalmodel {
  String status;
  String status_code;
  String message;

  Universalmodel(this.status, this.status_code, this.message);

  Universalmodel.map(dynamic obj) {
    this.status = obj["status"];
    this.status_code = obj["status_code"];
    this.message = obj["message"];
  }

  String get status1 => status;

  String get status_code1 => status_code;

  String get message1 => message;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["status"] = status;
    map["status_code"] = status_code;
    map["message"] = message;

    return map;
  }
}
