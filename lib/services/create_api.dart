import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CallApi {
  dynamic get(String url,  {dynamic headers}) async {
    http.Response response = await http.get(url, headers: headers);

    // if (response.statusCode == 401 && !StaticData.sessionEndedAlert && headers != null) {
    // sessionEnded(context: context, text: 'session');
    // }

    return response;
  }

  dynamic post(
      String url, dynamic data,{ dynamic headers}) async {
    http.Response response = await http.post(url, body: data, headers: headers);
    print('kjhj');

    // if (response.statusCode == 401 && !StaticData.sessionEndedAlert && headers != null )  {
    // sessionEnded(context: context, text: 'session');
    // }

    return response;
  }
}
