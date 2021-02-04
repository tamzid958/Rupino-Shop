import 'package:flutter/material.dart';
import 'package:shopaccount/constants.dart';
import 'package:shopaccount/src/models/costLists.dart';

import 'Lists.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(KdefaultPaddin),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: RaisedButton.icon(
              color: kOrangeColor,
              onPressed: () {},
              icon: Icon(
                Icons.add_box_rounded,
              ),
              label: Text("Add New Stock"),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 30,
            color: kBlackColor,
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
                    "Product Name",
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
                    height: 5,
                    color: kBlackColor,
                    thickness: 2,
                  ),
                  itemBuilder: (context, int index) => ShopLists(
                    shopList: listfiles[index],
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
