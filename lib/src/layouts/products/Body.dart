import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shopaccount/constants.dart';
import 'UpdateProduct.dart';
import 'package:shopaccount/src/services/crud.dart';
import 'AddNewProduct.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key key}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final formatCurrency = NumberFormat.compact();
  void _addNewProduct() {
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) => AddNewProduct(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(KdefaultPaddin),
      child: Container(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: RaisedButton.icon(
                color: kOrangeColor,
                onPressed: _addNewProduct,
                icon: Icon(
                  Icons.add_box_rounded,
                ),
                label: Text("New Product"),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 30,
              color: kLightBlueColor,
              child: Padding(
                padding:
                    EdgeInsets.fromLTRB(KdefaultPaddin, 0, KdefaultPaddin, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Product",
                      style: TextStyle(color: kWhiteColor),
                    ),
                    Text(
                      "Quantity",
                      style: TextStyle(color: kWhiteColor),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Stack(
              children: [
                FutureBuilder(
                  future: CRUD.getData('products'),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: snapshot.data.size,
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(
                          height: 10,
                          color: kLightBlueColor,
                          thickness: 1,
                        ),
                        itemBuilder: (context, int index) => Dismissible(
                          key: ObjectKey(snapshot.data.docs.elementAt(index)),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            setState(
                              () {
                                CRUD.deleteData(
                                    'products', snapshot.data.docs[index].id);
                              },
                            );
                          },
                          background: Container(
                            color: kRedColor,
                            child: Padding(
                              padding: EdgeInsets.all(KmodiPaddin),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(Icons.delete, color: kWhiteColor),
                                ],
                              ),
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              showMaterialModalBottomSheet(
                                context: context,
                                builder: (context) => UpdateProduct(
                                  data: snapshot.data.docs[index].id,
                                ),
                              );
                            },
                            child: ListTile(
                              tileColor: kTextLightColor,
                              leading: Text(snapshot.data.docs[index]['name']),
                              trailing: Chip(
                                backgroundColor: kAccentColor,
                                label: Text(
                                  formatCurrency.format(
                                    snapshot.data.docs[index]['stock'],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
