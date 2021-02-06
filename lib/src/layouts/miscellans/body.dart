import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shopaccount/constants.dart';
import 'package:shopaccount/src/layouts/miscellans/AddNewMisc.dart';
import 'package:shopaccount/src/services/crud.dart';

class MiscScreen extends StatefulWidget {
  const MiscScreen({
    Key key,
  }) : super(key: key);

  @override
  _MiscScreenState createState() => _MiscScreenState();
}

class _MiscScreenState extends State<MiscScreen> {
  final formatCurrency = NumberFormat.compact();
  @override
  Widget build(BuildContext context) {
    void _addNewMisc() {
      showMaterialModalBottomSheet(
        context: context,
        builder: (context) => AddNewMisc(),
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
              onPressed: _addNewMisc,
              icon: Icon(
                Icons.add_box_rounded,
              ),
              label: Text("New Misc."),
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
                    "Cost Name",
                    style: TextStyle(color: kWhiteColor),
                  ),
                  Text(
                    "Cost",
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
                  future: CRUD.getData('costs'),
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
                                snapshot.data.docs.removeAt(index);
                                CRUD.deleteData(
                                  'costs',
                                  snapshot.data.docs[index].id,
                                );
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
                            leading: Text(
                              snapshot.data.docs[index]['cost name'],
                            ),
                            trailing: Text(
                              "\৳ " +
                                  formatCurrency.format(
                                      snapshot.data.docs[index]['cost']),
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
