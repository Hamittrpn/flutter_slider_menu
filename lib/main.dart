import 'package:flutter/material.dart';
import 'menu_dashboard_widget.dart';

void main() {
  runApp(MyApp());

  //   SystemChrome.setSystemUIOverlayStyle(
  //     SystemUiOverlayStyle(statusBarColor: Colors.red));

  // SystemChrome.setPreferredOrientations(
  //         [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
  //     .then((value) {
  //   runApp(MyApp());
  // });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Menu Dashboard",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MenuDashboard(),
    );
  }
}
