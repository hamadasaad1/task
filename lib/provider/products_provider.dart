import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/model/products_model.dart';
import 'package:task/services/constans.dart';
import 'package:http/http.dart' as http;
import 'package:task/services/create_api.dart';

class ProductsProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String _errorMessage = "";
  ProductsModel _model;

  get getProductsModel => _model;

  String get errorMessage => _errorMessage;

  Future<Null> allProducts() async {
    _isLoading = true;
    notifyListeners();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userId = sharedPreferences.getString(USERID);
    String userName = sharedPreferences.getString(USERNAME);
    var gwtToken = sharedPreferences.getString(SECURITY_TOKEN);
    Map<dynamic, dynamic> _postData = {
      "name_en": userName,
      "page": "1",
      "norecord": "4",
      "key_search": ""
    };
    print('login' + json.encode(_postData));

    print(BASE_URL + ALL_PRODUCTS);
    http.Response response = await CallApi()
        .post(BASE_URL + ALL_PRODUCTS, _postData, headers: {HttpHeaders.authorizationHeader:gwtToken});

    final int statusCode = response.statusCode;
    print('login  statusCode = ' + statusCode.toString());
    print('login Body = ' + response.body.toString());
    if (statusCode < 200 || statusCode >= 400) {
      Map<String, dynamic> mapResponse = json.decode(response.body);

      print('mapResponse : $mapResponse');
      _errorMessage =
          mapResponse['message'] ?? mapResponse['message'] ?? "Error";
      _isLoading = false;
      notifyListeners();
    } else {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['status'].toString().contains('error')) {
        _errorMessage = jsonResponse['message'];
        _isLoading = false;
        notifyListeners();
      } else {
        _model = ProductsModel.fromJson(jsonResponse);
        _isLoading = false;
        notifyListeners();
      }
    }
  }
}
