import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shopaccount/constants.dart';
import 'package:shopaccount/src/layouts/damage/AddNewDamage.dart';
import 'package:shopaccount/src/models/costLists.dart';
import 'Lists.dart';

class DamageScreen extends StatefulWidget {
  const DamageScreen({
    Key key,
  }) : super(key: key);

  @override
  _DamageScreenState createState() => _DamageScreenState();
}

class _DamageScreenState extends State<DamageScreen> {
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
                    child: ShopLists(
                      listFiles: listfiles[index],
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
