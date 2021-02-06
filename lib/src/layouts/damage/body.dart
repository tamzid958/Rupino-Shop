import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shopaccount/constants.dart';
import 'package:shopaccount/src/layouts/damage/AddNewDamage.dart';
import 'package:shopaccount/src/services/crud.dart';

class DamageScreen extends StatefulWidget {
  const DamageScreen({
    Key key,
  }) : super(key: key);

  @override
  _DamageScreenState createState() => _DamageScreenState();
}

class _DamageScreenState extends State<DamageScreen> {
  final formatCurrency = NumberFormat.compact();
  @override
  Widget build(BuildContext context) {
    void _addNewDamage() {
      showMaterialModalBottomSheet(
        context: context,
        builder: (context) => AddNewDamage(),
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
              onPressed: _addNewDamage,
              icon: Icon(
                Icons.add_box_rounded,
              ),
              label: Text("New Damage"),
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
          Container(
            height: MediaQuery.of(context).size.height / 1.7,
            child: Stack(
              children: [
                FutureBuilder(
                  future: CRUD.getData('damages'),
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
                            setState(() {
                              snapshot.data.docs.removeAt(index);
                              CRUD.deleteData(
                                'damages',
                                snapshot.data.docs[index].id,
                              );
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
                            leading: Text(
                              snapshot.data.docs[index]['name'],
                            ),
                            trailing: Chip(
                              backgroundColor: kAccentColor,
                              label: Text(
                                formatCurrency.format(
                                  snapshot.data.docs[index]['quantity'],
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
          ),
        ],
      ),
    );
  }
}
