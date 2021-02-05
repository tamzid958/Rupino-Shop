import 'package:flutter/material.dart';
import 'package:shopaccount/constants.dart';
import 'package:shopaccount/src/services/crud.dart';

class AddNewProduct extends StatefulWidget {
  AddNewProduct({Key key}) : super(key: key);

  @override
  _AddNewProductState createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final productController = TextEditingController();
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
                  hintText: 'Enter Product Name',
                ),
                controller: productController,
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
              SizedBox(
                width: double.infinity,
                child: RaisedButton.icon(
                  color: kOrangeColor,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      // Process data.
                      String productName = productController.text;
                      Map<String, dynamic> data = {
                        "name": productName,
                        "stock": 0,
                        "profit": 0,
                      };
                      CRUD.addData('products', data);
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
