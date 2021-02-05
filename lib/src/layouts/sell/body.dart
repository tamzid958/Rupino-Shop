import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shopaccount/constants.dart';
import 'package:shopaccount/src/layouts/sell/AddNewSell.dart';
import 'package:shopaccount/src/services/crud.dart';

class SellScreen extends StatefulWidget {
  final String data;
  const SellScreen({Key key, @required this.data}) : super(key: key);

  @override
  _SellScreenState createState() => _SellScreenState(data: data);
}

class _SellScreenState extends State<SellScreen> {
  String data;
  _SellScreenState({this.data});
  final formatCurrency = NumberFormat.compact();
  @override
  Widget build(BuildContext context) {
    void _addNewSell() {
      showMaterialModalBottomSheet(
        context: context,
        builder: (context) => AddNewSell(data: data),
      );
    }

    return Padding(
      padding: EdgeInsets.all(KdefaultPaddin),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: RaisedButton.icon(
              color: kOrangeColor,
              onPressed: _addNewSell,
              icon: Icon(
                Icons.add_box_rounded,
              ),
              label: Text("New Sell"),
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
                    "Quantity",
                    style: TextStyle(color: kWhiteColor),
                  ),
                  Text(
                    "SubTotal (Per Quantity)",
                    style: TextStyle(color: kWhiteColor),
                  ),
                  Text(
                    "Shop",
                    style: TextStyle(color: kWhiteColor),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: MediaQuery.of(context).size.height / 1.7,
            child: Stack(
              children: [
                FutureBuilder(
                  future: CRUD.getChildData('products', 'sells', data),
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
                          key: ObjectKey(
                            snapshot.data.docs[index].id,
                          ),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            setState(() {
                              snapshot.data.docs.removeAt(index);
                              CRUD.deleteChildData('products', data, 'sells',
                                  snapshot.data.docs[index].id);
                              CRUD.updateData('products', data, {
                                'profit': FieldValue.increment(
                                  -(snapshot.data.docs[index]['quantity'] *
                                      snapshot.data.docs[index]
                                          ['per quantity price']),
                                ),
                                'stock': FieldValue.increment(
                                  snapshot.data.docs[index]['quantity'],
                                ),
                              });
                            });
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
                          child: ListTile(
                            tileColor: kTextLightColor,
                            leading: Chip(
                              backgroundColor: kAccentColor,
                              label: Text(formatCurrency.format(
                                  snapshot.data.docs[index]['quantity'])),
                            ),
                            title: Center(
                              child: Text(
                                "\৳ " +
                                    formatCurrency.format(
                                        snapshot.data.docs[index]['quantity'] *
                                            snapshot.data.docs[index]
                                                ['per quantity price']) +
                                    " (" +
                                    formatCurrency.format(snapshot.data
                                        .docs[index]['per quantity price']) +
                                    ")",
                              ),
                            ),
                            trailing: Text(
                              snapshot.data.docs[index]['shop name'],
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
          ),
        ],
      ),
    );
  }
}
