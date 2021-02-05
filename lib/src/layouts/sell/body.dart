import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shopaccount/constants.dart';
import 'package:shopaccount/src/layouts/sell/AddNewSell.dart';
import 'package:shopaccount/src/models/costLists.dart';
import 'UpdateSell.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({
    Key key,
  }) : super(key: key);

  @override
  _SellScreenState createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  final formatCurrency = NumberFormat.compact();
  @override
  Widget build(BuildContext context) {
    void _addNewSell() {
      showMaterialModalBottomSheet(
        context: context,
        builder: (context) => AddNewSell(),
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
                    "Product",
                    style: TextStyle(color: kWhiteColor),
                  ),
                  Text(
                    "Total Price",
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
                ListView.separated(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: listfiles.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(
                    height: 10,
                    color: kLightBlueColor,
                    thickness: 1,
                  ),
                  itemBuilder: (context, int index) => Dismissible(
                    key: Key(
                      listfiles[index].id.toString(),
                    ),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      setState(() {
                        listfiles.removeAt(index);
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
                    child: GestureDetector(
                      onTap: () {
                        showMaterialModalBottomSheet(
                          context: context,
                          builder: (context) => UpdateSell(),
                        );
                      },
                      child: ListTile(
                        tileColor: kTextLightColor,
                        leading: Chip(
                          backgroundColor: kAccentColor,
                          label: Text(formatCurrency.format(300)),
                        ),
                        title: Text(
                          "lorem",
                        ),
                        trailing: Text(
                          "\৳ " + formatCurrency.format(300),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
