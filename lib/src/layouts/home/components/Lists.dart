import 'package:flutter/material.dart';
import 'package:shopaccount/constants.dart';
import 'package:shopaccount/src/models/costLists.dart';

class ShopLists extends StatelessWidget {
  const ShopLists({
    Key key,
    ListFiles shopList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Chip(
        backgroundColor: kOrangeColor,
        label: Text("300"),
      ),
      title: Text(
        "lorem pusum dollar",
      ),
      trailing: Text(
        "\৳ 300",
      ),
    );
  }
}
