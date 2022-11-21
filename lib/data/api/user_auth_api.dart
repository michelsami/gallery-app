import 'dart:convert' as convert;

import 'package:gallery_app/data/api/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../app_constants.dart';
import '../models/meta_data.dart';
import '../models/user_response.dart';
import 'api_response_handler.dart';
import 'api_result.dart';
import 'failure.dart';

class AuthAPILogin {
  Future<APIResult> authenticateUserLogin(String email, String password) async {
    var jsonResponse;
    UserResponse userResponse;
    APIResult result = APIResult();

    var map = Map<String, dynamic>();

    map['email'] = email;
    map['password'] = password;

    try {
      http.Response response = await http.post(
        Uri.parse('${APIConstants.baseURL}${APIConstants.loginAuthPath}'),
        body: map,
      );

      if (response.statusCode == AppConstants.RESPONSE_CODE_SUCCESS) {
        jsonResponse = convert.jsonDecode(response.body);

        userResponse = UserResponse.fromJson(jsonResponse);

        //print("Token: " + userResponse.metaData.accessToken);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(
            AppConstants.KEY_ACCESS_TOKEN, userResponse.metaData.accessToken);

        result.hasError = false;
        result.data = userResponse.data;
      } else {
        jsonResponse = convert.jsonDecode(response.body);
        userResponse = UserResponse.fromJson(jsonResponse);
        MetaData? responseMeta = userResponse.metaData;

        result.hasError = true;
        result.failure =
            Failure(responseMeta?.code, responseMeta?.messages?.message);
      }
    } catch (e) {
      result = APIResponseErrorHandler.parseError(e);
    }

    print(result.data);
    return result;
  }
}
