import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task/services/constans.dart';
import 'package:http/http.dart' as http;
import 'package:task/services/create_api.dart';

class SignInProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  int userId;

  String _errorMessage = "";

  String get errorMessage => _errorMessage;



  Future<bool> signIn(
      String mobile, String password) async {
    _isLoading = true;
    notifyListeners();

    Map<String, dynamic> _postData = {
      "name_en": "Ahmed",
      "name_ar": "أحمد",
      "mobile": mobile,
      "password": password,
      "birthdate": "1435-05-14",
    };
    print('login' + json.encode(_postData));

    print(BASE_URL + SIGN_IN);
    http.Response response =
        await CallApi().post(BASE_URL + SIGN_IN, _postData);

    final int statusCode = response.statusCode;
    final String header = response.headers.toString();
    print('login  statusCode = ' + statusCode.toString());
    print('login Body = ' + response.body.toString());
    print('login Header = ' + response.headers.toString());
    if (statusCode < 200 || statusCode >= 400) {
      Map<String, dynamic> mapResponse = json.decode(response.body);

      print('mapResponse : $mapResponse');
      _errorMessage =
          mapResponse['message'] ? mapResponse['message'].toString() : "Error";
      _isLoading = false;
      notifyListeners();
      return false;
    } else {
      var jsonResponse = json.decode(response.body);
      if ( jsonResponse.toString().contains('error')) {
        _errorMessage =
        jsonResponse['message'];
        notifyListeners();
        return false;

      }
      _isLoading = false;
      notifyListeners();


      return true;

    }
  }
}
