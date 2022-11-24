import 'package:flutter/material.dart';
import 'package:test_app/screens/authenticate/login.dart';
import 'package:test_app/screens/authenticate/register.dart';

class Handler extends StatefulWidget {
  const Handler({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Handler();
  }
}

class _Handler extends State<Handler> {
  bool showSignin = true;

  void toggleView() {
    setState(() {
      showSignin = !showSignin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignin) {
      return Login(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
