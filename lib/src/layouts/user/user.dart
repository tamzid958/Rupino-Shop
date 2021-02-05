import 'package:flutter/material.dart';
import 'package:shopaccount/constants.dart';
import 'package:shopaccount/src/auth/provider.dart';

class UserScreen extends StatelessWidget {
  final VoidCallback onSignedOut;
  const UserScreen({Key key, this.onSignedOut}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var auth = AuthProvider.of(context).auth;

    Future<List> profileData = auth.getProfile();

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Padding(
        padding: EdgeInsets.all(KdefaultPaddin),
        child: FutureBuilder(
          future: profileData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Container(
                    child: Chip(
                      label: Text("Registered Mail: " + snapshot.data[0].email),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: FlatButton.icon(
                        color: kOrangeColor,
                        onPressed: () async {
                          try {
                            await auth.signOut();
                            onSignedOut();
                          } catch (e) {
                            print(e);
                          }
                        },
                        icon: Icon(Icons.logout),
                        label: Text("Sign Out")),
                  ),
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
