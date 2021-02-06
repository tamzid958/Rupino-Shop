import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopaccount/constants.dart';
import 'package:shopaccount/src/layouts/damage/body.dart';
import 'package:shopaccount/src/layouts/miscellans/body.dart';
import 'package:shopaccount/src/layouts/products/ProductList.dart';
import 'package:shopaccount/src/layouts/user/user.dart';

class ProductsScreen extends StatefulWidget {
  final VoidCallback onSignedOut;
  const ProductsScreen({Key key, this.onSignedOut}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  int _selectedIndex = 0;
  double profit = 0;
  double temptotal1 = 0, temptotal2 = 0;
  var productProfit, costLoss;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final formatCurrency = NumberFormat.compact();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    FirebaseFirestore.instance.collection('products').snapshots().listen(
      (snapshot) {
        for (int i = 0; i < snapshot.size; i++) {
          temptotal1 += snapshot.docs[i]['profit'];
        }
      },
    );
    FirebaseFirestore.instance.collection('costs').snapshots().listen(
      (snapshot) {
        for (int i = 0; i < snapshot.size; i++) {
          temptotal2 += snapshot.docs[i]['cost'];
        }
        setState(() {
          profit = temptotal1 - temptotal2;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [
      ProductList(),
      MiscScreen(),
      DamageScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            icon: Icon(Icons.supervised_user_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserScreen(
                    onSignedOut: widget.onSignedOut,
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(
                () {},
              );
            },
          ),
        ],
      ),
      body: _children[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(KdefaultPaddin),
              topLeft: Radius.circular(KdefaultPaddin)),
          boxShadow: [
            BoxShadow(color: kAccentColor, spreadRadius: 0, blurRadius: 0),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(KdefaultPaddin),
            topRight: Radius.circular(KdefaultPaddin),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.inventory),
                label: 'Product',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.explicit),
                label: 'Misc.',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.broken_image_outlined),
                label: 'Damage',
              ),
            ],
            currentIndex: _selectedIndex,
            unselectedItemColor: kAshColor,
            onTap: _onItemTapped,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: kBlueColor,
        label: Text("\৳ " + formatCurrency.format(profit)),
        icon: Icon(
          Icons.timeline,
          color: kWhiteColor,
        ),
        onPressed: () => null,
      ),
    );
  }
}
