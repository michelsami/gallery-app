import 'package:flutter/material.dart';

import '../data/api/api_result.dart';
import '../data/api/user_auth_api.dart';
import '../providers/login_provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String errorString = "";
  late LoginProvider loginProvider;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(40.0),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/love_photograph.png'),
            SizedBox(
              height: 20,
            ),
            Text("My"),
            Text("Gallery"),
            SizedBox(
              height: 30,
            ),
            Container(
              //width: MediaQuery.of(context).size.width * 0.9,
              child: Column(
                children: [
                  Text("Log in"),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(hintText: 'Email'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(hintText: 'Password'),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      Future<APIResult> test = AuthAPILogin()
                          .authenticateUserLogin(
                              _emailController.text, _passwordController.text);
                      print(_passwordController.text);
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Color(0xff7bb3ff),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text('Submit'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
