import 'package:flutter/material.dart';
import 'package:gallery_app/providers/login_provider.dart';
import 'package:gallery_app/screens/login-screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),
    ], child: MyGalleryApp()),
  );
}

class MyGalleryApp extends StatelessWidget {
  const MyGalleryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Login(),
      ),
    );
  }
}
