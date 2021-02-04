import 'package:flutter/material.dart';
import 'package:shopaccount/constants.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(KdefaultPaddin),
        child: SizedBox(
          width: double.infinity,
          child: FlatButton.icon(
              color: kOrangeColor,
              onPressed: () {},
              icon: Icon(Icons.logout),
              label: Text("Sign Out")),
        ),
      ),
    );
  }
}
