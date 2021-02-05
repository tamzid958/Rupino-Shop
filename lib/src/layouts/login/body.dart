import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:shopaccount/constants.dart';
import 'package:shopaccount/src/auth/provider.dart';

class LoginBodyScreen extends StatefulWidget {
  final VoidCallback onSignedIn;
  LoginBodyScreen({Key key, this.onSignedIn}) : super(key: key);

  @override
  _LoginBodyScreenState createState() => _LoginBodyScreenState();
}

class _LoginBodyScreenState extends State<LoginBodyScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _signIn(BuildContext context) async {
    try {
      var auth = AuthProvider.of(context).auth;
      await auth.googleSignIn();
      widget.onSignedIn();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(KdefaultPaddin * 3),
      color: kBlueColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SignInButton(
              Buttons.Google,
              onPressed: () => _signIn(context),
            ),
          ],
        ),
      ),
    );
  }
}
