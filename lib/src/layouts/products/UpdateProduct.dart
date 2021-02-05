import 'package:flutter/material.dart';
import 'package:shopaccount/constants.dart';
import 'package:shopaccount/src/services/crud.dart';

class UpdateProduct extends StatefulWidget {
  final String data;
  UpdateProduct({Key key, @required this.data}) : super(key: key);

  @override
  _UpdateProductState createState() => _UpdateProductState(data: data);
}

class _UpdateProductState extends State<UpdateProduct> {
  var productController;
  String data;
  _UpdateProductState({this.data});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void initstate() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(data);
    return Padding(
      padding: EdgeInsets.all(KdefaultPaddin),
      child: Container(
        height: MediaQuery.of(context).size.height / 1.7,
        child: FutureBuilder(
          future: CRUD.singleData('products', data),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              productController =
                  TextEditingController(text: snapshot.data["name"]);
              return Form(
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
                            Map<String, dynamic> updateData = {
                              "name": productName
                            };
                            CRUD.updateData('products', data, updateData);
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
