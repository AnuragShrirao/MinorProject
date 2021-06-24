import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);
  final String url;
  Future getData(
      {@required int aggregate,
      @required int technical,
      @required int communication,
      @required int backlogs}) async {

    var reqBody = new Map();

    reqBody['aggregate'] = aggregate;
    reqBody['technical'] = technical;
    reqBody['communication'] = communication;
    reqBody['backlogs'] = backlogs;

    http.Response response = await http.post(
      url,
      body: jsonEncode(reqBody),
    );
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode.toString());
    }
  }
}
