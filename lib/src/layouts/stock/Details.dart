import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shopaccount/constants.dart';
import 'package:shopaccount/src/models/costLists.dart';

import 'UpdateStock.dart';

class DetailScreen extends StatelessWidget {
  final ListFiles listfile;
  const DetailScreen({Key key, this.listfile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.compact();
    void _updateStock() {
      showMaterialModalBottomSheet(
        context: context,
        builder: (context) => UpdateStock(),
      );
    }

    return Container(
      height: MediaQuery.of(context).size.height / 1.7,
      child: Padding(
        padding: EdgeInsets.all(KdefaultPaddin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Product Name: " + listfile.title,
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Total Quantity: " + formatCurrency.format(listfile.quantity),
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Per Quantity Price: " +
                  formatCurrency.format(listfile.perQuantityPrice),
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Total Price: " +
                  formatCurrency
                      .format(listfile.quantity * listfile.perQuantityPrice),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              width: double.infinity,
              child: RaisedButton.icon(
                color: kOrangeColor,
                onPressed: _updateStock,
                icon: Icon(
                  Icons.add_box_rounded,
                ),
                label: Text("Update Stock"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
