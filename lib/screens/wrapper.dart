import 'package:provider/provider.dart';
import '../models/firebaseuser.dart';
import 'package:flutter/material.dart';

import 'authenticate/handler.dart';
import 'home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser?>(context);

    if (user == null) {
      return const Handler();
    } else {
      return const NhomePage();
    }
  }
}
