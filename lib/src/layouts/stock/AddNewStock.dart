import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopaccount/constants.dart';
import 'package:shopaccount/src/services/crud.dart';

class AddNewStock extends StatefulWidget {
  final String data;
  AddNewStock({Key key, @required this.data}) : super(key: key);

  @override
  _AddNewStockState createState() => _AddNewStockState(data: data);
}

class _AddNewStockState extends State<AddNewStock> {
  String data;
  _AddNewStockState({this.data});
  String chosenProduct;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final totalQuantityController = TextEditingController();
  final perQuantityPriceController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

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
                          'stock': FieldValue.increment(quantity),
                          'profit': FieldValue.increment(
                            -(perQuantityPirce * quantity),
                          )
                        },
                      );
                      CRUD.addChildData(
                        'products',
                        data,
                        'stocks',
                        {
                          'per quantity price': perQuantityPirce,
                          'quantity': quantity
                        },
                      );
                      Navigator.pop(context);
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
