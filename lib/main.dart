import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'models/firebaseuser.dart';
import 'screens/services/auth.dart';
import 'screens/wrapper.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBQ3-C-vlfDp_MaFIB_Xq9slCBb2Ga_iPw",
      authDomain: "test-project-3a651.firebaseapp.com",
      projectId: "test-project-3a651",
      storageBucket: "test-project-3a651.appspot.com",
      messagingSenderId: "526528834570",
      appId: "1:526528834570:web:1fc1b661c9d7337f7143f3",
      measurementId: "G-7QKCVY1QMF",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<FirebaseUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.black,
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.black,
            textTheme: ButtonTextTheme.primary,
            colorScheme:
                Theme.of(context).colorScheme.copyWith(secondary: Colors.white),
          ),
          fontFamily: 'Georgia',
          textTheme: const TextTheme(
            headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            headline6: TextStyle(fontSize: 20.0, fontStyle: FontStyle.normal),
            bodyText2: TextStyle(fontSize: 18.0, fontFamily: 'Hind'),
          ),
        ),
        home: const Wrapper(),
      ),
    );
  }
}
