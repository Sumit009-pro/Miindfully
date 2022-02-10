import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserModel {
  static final String prefUserData = 'UserData';

  static final String prefChildData = 'ChildData';
  String? id;
  String? name;
  String? image;
  String? email;
  String? createdDate;
  String? dateOfBirth;
  String? gender;
  String? password;
  String? token;
  String? apiToken;

  UserModel(
      {this.id,
      this.name,
      this.image,
      this.email,
      this.createdDate,
      this.dateOfBirth,
      this.gender,
      this.password});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'] != null ? json['name'].toString() : "";
    // dateOfBirth =
    //     json['dateOfBirth'] != null ? json['dateOfBirth'].toString() : "";
    apiToken = json['authToken'];
    // image = json['image'] != null ? json['image'].toString() : "";
    //createdDate = json['createdAt'] != null ? json['createdAt'].toString() : "";
    email =
        json['email'] != null && json['email'] != "null" && json['email'] != ""
            ? json['email'].toString()
            : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['deviceType'] = "APP";
    // data['dateOfBirth'] = this.dateOfBirth;
    data['_id'] = this.id;
    // data['image'] = this.image;
    // data['createdDate'] = this.createdDate;
    data['password'] = this.password;
    data['email'] = this.email;
    return data;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map<String, dynamic>();
    map['email'] = this.email;
    map['password'] = this.password;
    map['deviceToken'] = this.token;
    map['deviceType'] = "APP";
    return map;
  }

  static Future<UserModel?> readStringPref(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString(key);
    if (userData == null)
      return null;
    else
      return UserModel.fromJson(json.decode(json.decode((userData))));
  }

  static Future<bool> saveStringPref(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }
}
