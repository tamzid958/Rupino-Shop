import 'package:flutter/material.dart';
import 'package:shopaccount/constants.dart';
import 'package:shopaccount/src/models/costLists.dart';
import 'package:intl/intl.dart';

class ShopLists extends StatelessWidget {
  final ListFiles listFiles;
  final Function press;
  const ShopLists({Key key, @required this.listFiles, this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.compact();
    return GestureDetector(
      onTap: press,
      child: ListTile(
        tileColor: kTextLightColor,
        leading: Chip(
          backgroundColor: kAccentColor,
          label: Text(
            formatCurrency.format(listFiles.quantity),
          ),
        ),
        title: Text(
          listFiles.title,
        ),
        trailing: Text(
          "\৳ " +
              formatCurrency
                  .format(listFiles.perQuantityPrice * listFiles.quantity),
        ),
      ),
    );
  }
}
