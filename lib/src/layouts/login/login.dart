import 'package:flutter/material.dart';
import 'body.dart';

class LoginScreen extends StatelessWidget {
  final VoidCallback onSignedIn;
  const LoginScreen({Key key, this.onSignedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginBodyScreen(onSignedIn: onSignedIn),
    );
  }
}
