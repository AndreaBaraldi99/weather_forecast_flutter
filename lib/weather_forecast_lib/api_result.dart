import 'package:flutter/cupertino.dart';

class ApiResult {
  late String response;
  late int responseCode;

  ApiResult(String response, int responseCode) {
    this.response = response;
    this.responseCode = responseCode;
  }

  ApiResult.empty();
}
