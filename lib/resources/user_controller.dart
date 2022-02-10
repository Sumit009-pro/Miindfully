import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:miindfully/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:miindfully/models/category.dart';
import 'package:miindfully/models/category_base.dart';
import 'package:miindfully/models/reply.dart';
import 'package:miindfully/models/user_model.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

List bannersList = [];

class UserController extends ControllerMVC {
  Future<SharedPreferences> sharedPrefs = SharedPreferences.getInstance();
  ValueNotifier<UserModel> user = ValueNotifier(UserModel());
  List<Category> categories = <Category>[];
  List<String> images = <String>[
    "assets/images/fiords.jpg",
    //"assets/images/Leopard.jpg",
    "assets/images/mountain.jpg",
    "assets/images/river.jpg",
  ];
  List childrenList = [];
  List categoriesList = [];
  List subCategoriesList = [];
  List subscriptionsTypeList = [];
  List favoritesList = [];

  UserController() {
    setValue();
  }
  Future<bool> login(Map<String, dynamic> body) async {
    bool returnValue = false;
    final prefs = await sharedPrefs;
    final url =
    Uri.parse("https://externalnode.mydevfactory.com:1971/api/login");
    final response = await post(url, body: body);
    final result = Reply.fromMap(json.decode(response.body));
    if (result.base.code == 200) {
      //print(json.decode(response.body)['response_data']);
      returnValue = true;
      user.value = UserModel.fromJson(result.data);
      prefs.setString("userData", jsonEncode(json.decode(response.body)['response_data']));
      prefs.setString("userID", json.decode(response.body)['response_data']["_id"]);
      prefs.setString("authToken", user.value.apiToken!);
      prefs.setString("_id", user.value.id!);
      Fluttertoast.showToast(msg: result.base.message + " !!!!!");
    } else
      Fluttertoast.showToast(msg: result.base.message + " !!!!!");
    return returnValue;
  }

  Future<bool> register(Map<String, dynamic> body) async {
    bool returnValue = false;
    final prefs = await sharedPrefs;
    final url =
    Uri.parse("https://externalnode.mydevfactory.com:1971/api/register");
    final response = await post(url, body: body);
    final result = Reply.fromMap(json.decode(response.body));
    if (result.base.code == 200) {
      returnValue = true;
      /*login({
        "email": body["email"],
        "password": body["password"],
        "deviceType": "APP",
        "deviceToken" : "sdfgdfgd"
      });
      user.value = UserModel.fromJson(result.data);
      prefs.setString("userData", jsonEncode(json.decode(response.body)['response_data']));
      prefs.setString("userID", json.decode(response.body)['response_data']["_id"]);
      prefs.setString("authToken", user.value.apiToken!);
      prefs.setString("_id", user.value.id!);*/
      Fluttertoast.showToast(msg: result.base.message + " !!!!!");
    } else
      Fluttertoast.showToast(msg: result.base.message + " !!!!!");
    return returnValue;
  }

  void setValue() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    if (user.value.token == null || user.value.token!.isEmpty)
      user.value.token = androidInfo.id;
  }

  Future<List> waitForCategories(body) async {
    try {
      final prefs = await sharedPrefs;
      String? apiToken = prefs.getString("authToken");
      //final body = {"_id": prefs.getString("userID")};
      final url = Uri.parse(
          "https://externalnode.mydevfactory.com:1971/api/getallcategories");
      print(prefs.getString("apiToken"));
      final result = await post(url, body: body, headers: {
        'authToken': apiToken!,
        //'Content-Type': 'Application/Json'
      });
      print(jsonDecode(result.body));
      //final value = CategoryBase.fromMap(json.decode(result.body));
      if (jsonDecode(result.body)["STATUSCODE"] == 200)
        categoriesList = jsonDecode(result.body)["response"]["data"];
    } catch (e) {
      rethrow;
    }
    return categoriesList;
  }

  Future<List> waitForSubCategories(body) async {
    try {
      final prefs = await sharedPrefs;
      String? apiToken = prefs.getString("authToken");
      //final body = {"_id": prefs.getString("userID")};
      final url = Uri.parse(
          "https://externalnode.mydevfactory.com:1971/api/getallsubcategoriesbycatid");
      print(prefs.getString("apiToken"));
      final result = await post(url, body: body, headers: {
        'authToken': apiToken!,
        //'Content-Type': 'Application/Json'
      });
      print(jsonDecode(result.body));
      //final value = CategoryBase.fromMap(json.decode(result.body));
      if (jsonDecode(result.body)["STATUSCODE"] == 200)
        subCategoriesList = jsonDecode(result.body)["response"]["data"];
    } catch (e) {
      rethrow;
    }
    return subCategoriesList;
  }

  Future<List> waitForSubCategoriesDetails(body) async {
    try {
      final prefs = await sharedPrefs;
      String? apiToken = prefs.getString("authToken");
      //final body = {"_id": prefs.getString("userID")};
      final url = Uri.parse(
          "https://externalnode.mydevfactory.com:1971/api/getsubcatdetail");
      print(prefs.getString("apiToken"));
      final result = await post(url, body: body, headers: {
        'authToken': apiToken!,
        //'Content-Type': 'Application/Json'
      });
      print(jsonDecode(result.body));
      //final value = CategoryBase.fromMap(json.decode(result.body));
      if (jsonDecode(result.body)["STATUSCODE"] == 200)
        categoriesList = jsonDecode(result.body)["response"]["data"];
    } catch (e) {
      rethrow;
    }
    return categoriesList;
  }

  Future<List> waitForBannersList(body) async {
    try {
      final prefs = await sharedPrefs;
      String? apiToken = prefs.getString("authToken");
      //final body = {"_id": prefs.getString("userID")};
      final url = Uri.parse(
          "https://externalnode.mydevfactory.com:1971/api/getallbanners");
      print(prefs.getString("apiToken"));
      final result = await post(url, body: body, headers: {
        'authToken': apiToken!,
        //'Content-Type': 'Application/Json'
      });
      print(jsonDecode(result.body));
      //final value = CategoryBase.fromMap(json.decode(result.body));
      if (jsonDecode(result.body)["STATUSCODE"] == 200)
        bannersList = jsonDecode(result.body)["response"]["data"];
    } catch (e) {
      rethrow;
    }
    return bannersList;
  }

  Future<bool> addChild(body) async {
    bool returnValue = false;
    try {
      final prefs = await sharedPrefs;
      String? apiToken = prefs.getString("authToken");
      //final body = {"_id": prefs.getString("userID")};
      final url = Uri.parse(
          "https://externalnode.mydevfactory.com:1971/api/addchild");
      print(prefs.getString("apiToken"));
      final result = await post(url, body: body, headers: {
        'authToken': apiToken!,
        //'Content-Type': 'Application/Json'
      });
      print(result.body);
      //final value = CategoryBase.fromMap(json.decode(result.body));
      if (jsonDecode(result.body)["STATUSCODE"] == 200)
        print("<<SUCCESS>>");
        returnValue = true;
    } catch (e) {
      rethrow;
    }
    return returnValue;
  }

  Future<List> getChildren(body) async {
    try {
      final prefs = await sharedPrefs;
      String? apiToken = prefs.getString("authToken");
      //final body = {"_id": prefs.getString("userID")};
      final url = Uri.parse(
          "https://externalnode.mydevfactory.com:1971/api/getallchildren");
      print(prefs.getString("apiToken"));
      final result = await post(url, body: body, headers: {
        'authToken': apiToken!,
        //'Content-Type': 'Application/Json'
      });
      print(jsonDecode(result.body));
      //final value = CategoryBase.fromMap(json.decode(result.body));
      if (jsonDecode(result.body)["STATUSCODE"] == 200)
        childrenList = jsonDecode(result.body)["response"]["data"];
    } catch (e) {
      rethrow;
    }
    return childrenList;
  }

  Future<List> getSubscriptionType(body) async {
    try {
      final prefs = await sharedPrefs;
      String? apiToken = prefs.getString("authToken");
      //final body = {"_id": prefs.getString("userID")};
      final url = Uri.parse(
          "https://externalnode.mydevfactory.com:1971/api/getallsubscriptiontypes");
      print(prefs.getString("apiToken"));
      final result = await post(url, body: body, headers: {
        'authToken': apiToken!,
        //'Content-Type': 'Application/Json'
      });
      print("getallsubscriptiontypes>>>"+jsonDecode(result.body).toString());
      //final value = CategoryBase.fromMap(json.decode(result.body));
      if (jsonDecode(result.body)["STATUSCODE"] == 200)
        subscriptionsTypeList = jsonDecode(result.body)["response"]["data"];
    } catch (e) {
      rethrow;
    }
    return subscriptionsTypeList;
  }

  Future<List> getFavorites(body) async {
    try {
      final prefs = await sharedPrefs;
      String? apiToken = prefs.getString("authToken");
      //final body = {"_id": prefs.getString("userID")};
      final url = Uri.parse(
          "https://externalnode.mydevfactory.com:1971/api/get-favouritelist");
      print(prefs.getString("apiToken"));
      final result = await post(url, body: body, headers: {
        'authToken': apiToken!,
        //'Content-Type': 'Application/Json'
      });
      print("get favorites>>>"+jsonDecode(result.body).toString());
      //final value = CategoryBase.fromMap(json.decode(result.body));
      if (jsonDecode(result.body)["STATUSCODE"] == 200)
        favoritesList = jsonDecode(result.body)["response"]["data"];
    } catch (e) {
      rethrow;
    }
    return favoritesList;
  }

  Future addToFavorites(body) async {
    var responseData;
    try {
      final prefs = await sharedPrefs;
      String? apiToken = prefs.getString("authToken");
      //final body = {"_id": prefs.getString("userID")};
      final url = Uri.parse(
          "https://externalnode.mydevfactory.com:1971/api/add-to-favouritelist");
      print(prefs.getString("apiToken"));
      final result = await post(url, body: body, headers: {
        'authToken': apiToken!,
        //'Content-Type': 'Application/Json'
      });
      print("add favorites>>>"+jsonDecode(result.body).toString());
      //final value = CategoryBase.fromMap(json.decode(result.body));
      if (result.statusCode == 200)
         responseData = jsonDecode(result.body);
      print("?????????????"+responseData.toString());
    } catch (e) {
      rethrow;
    }
    return responseData;
  }


}

