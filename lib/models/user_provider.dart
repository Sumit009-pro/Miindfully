import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:miindfully/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  // final _helper = CatPhotoHelper();
  final Map<String, String> _headers = {'Accept': 'application/json'};
  final _streamController = StreamController<UserModel>();
  Stream<UserModel> login() {
    _streamController.close();
    return _streamController.stream;
  }

  Future<UserModel> fetchExchangeRates() async {
    final uri = Uri.parse("https://nodeserver.mydevfactory.com:1971/api/login");
    final results = await post(uri, headers: _headers);
    final jsonObject = json.decode(results.body);
    return UserModel.fromJson(jsonObject);
  }
}
