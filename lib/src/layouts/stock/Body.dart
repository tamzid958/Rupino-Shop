import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shopaccount/constants.dart';
import 'package:shopaccount/src/layouts/stock/AddNewStock.dart';
import 'package:shopaccount/src/layouts/stock/UpdateStock.dart';
import 'package:shopaccount/src/models/costLists.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({
    Key key,
  }) : super(key: key);

  @override
  _StockScreenState createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  final formatCurrency = NumberFormat.compact();
  @override
  Widget build(BuildContext context) {
    void _addNewStock() {
      showMaterialModalBottomSheet(
        context: context,
        builder: (context) => AddNewStock(),
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
            child: ListView.separated(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: listfiles.length,
              separatorBuilder: (BuildContext context, int index) => Divider(
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
                      builder: (context) => UpdateStock(
                        listfile: listfiles[index],
                      ),
                    );
                  },
                  child: ListTile(
                    tileColor: kTextLightColor,
                    leading: Chip(
                      backgroundColor: kAccentColor,
                      label: Text(
                        formatCurrency.format(30),
                      ),
                    ),
                    title: Text(
                      "Title",
                    ),
                    trailing: Text(
                      "\৳ " + formatCurrency.format(400),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
