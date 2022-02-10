import 'package:miindfully/models/base.dart';

class Reply {
  Base base;
  Map<String, dynamic> data;
  Reply(this.base, this.data);
  factory Reply.fromMap(Map<String, dynamic> json) {
    return Reply(
        Base.fromMap(json), json['response_data'] ?? (json['response'] ?? {}));
  }

  factory Reply.fromJSON(Map<String, dynamic> json) {
    return Reply(
        Base.fromJSON(json), json['response'] ?? (json['response_data'] ?? {}));
  }
}
