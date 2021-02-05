import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopaccount/constants.dart';
import 'package:shopaccount/src/auth/auth.dart';
import 'package:shopaccount/src/auth/provider.dart';
import 'package:shopaccount/src/auth/root.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp();
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<FirebaseApp> _initialization;

  @override
  void initState() {
    _initialization = Firebase.initializeApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          // return SomethingWentWrong();
          print('Something went wrong in Flutter Fire');
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MyMaterialApp();
        } else {
          return Container(
            color: kBlueColor,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthProvider(
      auth: AuthService(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Rupino Shop',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: "Helvetica",
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: RootPage(),
      ),
    );
  }
}
