import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopaccount/constants.dart';
import 'package:shopaccount/src/models/costLists.dart';

class ShopLists extends StatelessWidget {
  final ListFiles listFiles;
  const ShopLists({
    Key key,
    @required this.listFiles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.compact();
    return ListTile(
      tileColor: kTextLightColor,
      leading: Chip(
        backgroundColor: kAccentColor,
        label: Text(formatCurrency.format(listFiles.quantity)),
      ),
      title: Text(
        listFiles.title,
      ),
      trailing: Text(
        "\৳ " +
            formatCurrency
                .format(listFiles.perQuantityPrice * listFiles.quantity),
      ),
    );
  }
}
