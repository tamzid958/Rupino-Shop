import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:shopaccount/constants.dart';
import 'package:shopaccount/src/models/costLists.dart';

class AddNewReturn extends StatefulWidget {
  final String data;
  AddNewReturn({Key key, @required this.data}) : super(key: key);

  @override
  _AddNewReturnState createState() => _AddNewReturnState(data: data);
}

class _AddNewReturnState extends State<AddNewReturn> {
  String data;
  _AddNewReturnState({this.data});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(KdefaultPaddin),
      child: Container(
        height: MediaQuery.of(context).size.height / 1.7,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Shop Name',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Quantity',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some number';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                width: double.infinity,
                child: RaisedButton.icon(
                  color: kOrangeColor,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      // Process data.
                    }
                  },
                  icon: Icon(
                    Icons.done,
                  ),
                  label: Text("Submit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
