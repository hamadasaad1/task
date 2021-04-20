import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task/services/constans.dart';
import 'package:http/http.dart' as http;
import 'package:task/services/create_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  int userId;

  String _errorMessage = "";

  String get errorMessage => _errorMessage;

  Future<bool> signUp(
      {String nameEn,
      String nameAr,
      String birthdate,
      String mobile,
      String password}) async {
    _isLoading = true;
    notifyListeners();

    Map<String, dynamic> _postData = {
      "name_en": nameEn,
      "name_ar": nameAr,
      "mobile": mobile,
      "password": password,
      "birthdate": birthdate,
    };
    print('login' + json.encode(_postData));

    print(BASE_URL + SIGN_UP);
    http.Response response =
        await CallApi().post(BASE_URL + SIGN_UP, _postData);

    final int statusCode = response.statusCode;
    print('SIGN_UP  statusCode = ' + statusCode.toString());
    print('SIGN_UP Body = ' + response.body.toString());
    if (statusCode < 200 || statusCode >= 400) {
      Map<String, dynamic> mapResponse = json.decode(response.body);

      print('mapResponse : $mapResponse');
      _errorMessage =
          mapResponse['message'] ?? mapResponse['message'] ?? "Error";
      _isLoading = false;
      notifyListeners();
      return false;
    } else {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['status'].toString().contains('error')) {
        _errorMessage = jsonResponse['message'];
        _isLoading = false;
        notifyListeners();
        return false;
      }else{
        _saveDate(jsonResponse["data"]["name_en"], jsonResponse["data"]["id"].toString(),
            jsonResponse["data"]["api_token"]);
        _isLoading = false;
        notifyListeners();
        return false;
      }



    }
  }

  _saveDate(String name, String id, String apiToken) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(SECURITY_TOKEN, apiToken);
    sharedPreferences.setString(USERID, id);
    sharedPreferences.setString(USERNAME, name);
  }
}
