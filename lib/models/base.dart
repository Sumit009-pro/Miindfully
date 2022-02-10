class Base {
  bool success;
  int code;
  String message;
  Base(this.success, this.code, this.message);
  factory Base.fromMap(Map<String, dynamic> json) {
    return Base(
        json['success'] ?? true,
        json['response_code'] ?? json['STATUSCODE'],
        json['response_message'] ?? json['message']);
  }

  factory Base.fromJSON(Map<String, dynamic> json) {
    return Base(
        json['success'] ?? false,
        json['STATUSCODE'] ?? json['response_code'],
        json['message'] ?? json['response_message']);
  }
}
