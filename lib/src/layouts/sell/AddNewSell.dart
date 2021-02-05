import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopaccount/constants.dart';
import 'package:shopaccount/src/services/crud.dart';

class AddNewSell extends StatefulWidget {
  final String data;
  AddNewSell({Key key, @required this.data}) : super(key: key);

  @override
  _AddNewSellState createState() => _AddNewSellState(data: data);
}

class _AddNewSellState extends State<AddNewSell> {
  String data;
  _AddNewSellState({this.data});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final totalQuantityController = TextEditingController();
  final perQuantityPriceController = TextEditingController();
  final shopNameController = TextEditingController();
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
                controller: shopNameController,
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
                controller: totalQuantityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Total Quantity',
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
              TextFormField(
                controller: perQuantityPriceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Per Quantity Price',
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
                      double perQuantityPirce =
                          double.parse(perQuantityPriceController.text);
                      double quantity =
                          double.parse(totalQuantityController.text);
                      CRUD.updateData(
                        'products',
                        data,
                        {
                          'stock': FieldValue.increment(-quantity),
                          'profit': FieldValue.increment(
                            (perQuantityPirce * quantity),
                          )
                        },
                      );
                      CRUD.addChildData(
                        'products',
                        data,
                        'sells',
                        {
                          'shop name': shopNameController.text,
                          'quantity': quantity,
                          'per quantity price': perQuantityPirce
                        },
                      );
                    }
                    Navigator.pop(context);
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
