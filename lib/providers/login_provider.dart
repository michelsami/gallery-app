import 'package:flutter/material.dart';

import '../data/api/api_result.dart';
import '../data/models/user_model.dart';

enum LoginScreenState { initial, loading, loaded, error }

class LoginProvider with ChangeNotifier {
  LoginScreenState state = LoginScreenState.initial;
  late User user;
  late APIResult apiResult;
  late String errorMessage;

  login(userName, password) async {
    setState(LoginScreenState.loading);
    // apiResult = await UsersAuthAPI().login(userName, password);

    if (!apiResult.hasError) {
      user = apiResult.data;
      setState(LoginScreenState.loaded);
    } else {
      errorMessage = apiResult.failure.message!;
      setState(LoginScreenState.error);
    }
  }

  setState(state) {
    this.state = state;
    notifyListeners();
  }
}
