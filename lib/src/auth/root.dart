import 'package:flutter/material.dart';
import 'package:shopaccount/src/auth/provider.dart';
import 'package:shopaccount/src/layouts/home/home.dart';
import 'package:shopaccount/src/layouts/login/login.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

enum AuthStatus { notSigned, signed }

class _RootPageState extends State<RootPage> {
  AuthStatus _authStatus = AuthStatus.notSigned;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var auth = AuthProvider.of(context).auth;
    auth.currentUser().then((userId) {
      setState(() {
        _authStatus = userId == null ? AuthStatus.notSigned : AuthStatus.signed;
      });
    }).catchError((Object error) {
      _authStatus = AuthStatus.notSigned;
    });
  }

  void _signedIn() {
    setState(() {
      _authStatus = AuthStatus.signed;
    });
  }

  void _signedOut() {
    setState(() {
      _authStatus = AuthStatus.notSigned;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_authStatus) {
      case AuthStatus.notSigned:
        return LoginScreen(); //onSignedIn: _signedIn
        break;
      case AuthStatus.signed:
        return HomeScreen(); //onSignedOut: _signedOut
        break;
      default:
        return CircularProgressIndicator();
        break;
    }
  }
}
