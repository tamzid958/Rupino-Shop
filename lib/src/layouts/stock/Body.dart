import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shopaccount/constants.dart';
import 'package:shopaccount/src/layouts/stock/AddNewStock.dart';
import 'package:shopaccount/src/services/crud.dart';

class StockScreen extends StatefulWidget {
  final String data;
  const StockScreen({Key key, @required this.data}) : super(key: key);

  @override
  _StockScreenState createState() => _StockScreenState(data: data);
}

class _StockScreenState extends State<StockScreen> {
  String data;
  _StockScreenState({this.data});
  final formatCurrency = NumberFormat.compact();
  @override
  Widget build(BuildContext context) {
    void _addNewStock() {
      showMaterialModalBottomSheet(
        context: context,
        builder: (context) => AddNewStock(data: data),
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
              onPressed: _addNewStock,
              icon: Icon(
                Icons.add_box_rounded,
              ),
              label: Text("New Stock"),
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
                    "Per Quantity Price",
                    style: TextStyle(color: kWhiteColor),
                  ),
                  Text(
                    "Total",
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
            child: FutureBuilder(
                future: CRUD.getChildData('products', 'stocks', data),
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
                          setState(
                            () {
                              snapshot.data.docs.removeAt(index);
                              CRUD.updateData(
                                'products',
                                data,
                                {
                                  'profit': FieldValue.increment(
                                    snapshot.data.docs[index]['quantity'] *
                                        snapshot.data.docs[index]
                                            ['per quantity price'],
                                  ),
                                  'stock': FieldValue.increment(
                                    -snapshot.data.docs[index]['quantity'],
                                  ),
                                },
                              );
                              CRUD.deleteChildData('products', data, 'stocks',
                                  snapshot.data.docs[index].id);
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
                        child: ListTile(
                          tileColor: kTextLightColor,
                          leading: Chip(
                            backgroundColor: kAccentColor,
                            label: Text(
                              formatCurrency.format(
                                snapshot.data.docs[index]['quantity'],
                              ),
                            ),
                          ),
                          title: Center(
                            child: Text(
                              "\৳ " +
                                  formatCurrency.format(
                                    snapshot.data.docs[index]
                                        ['per quantity price'],
                                  ),
                            ),
                          ),
                          trailing: Text(
                            "\৳ " +
                                formatCurrency.format(
                                  snapshot.data.docs[index]['quantity'] *
                                      snapshot.data.docs[index]
                                          ['per quantity price'],
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
                }),
          ),
        ],
      ),
    );
  }
}
