import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopaccount/src/layouts/login/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rupino Shop',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Helvetica",
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
    );
  }
}
