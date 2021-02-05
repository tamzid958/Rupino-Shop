import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopaccount/constants.dart';
import 'package:shopaccount/src/layouts/damage/body.dart';
import 'package:shopaccount/src/layouts/miscellans/body.dart';
import 'package:shopaccount/src/layouts/return/body.dart';
import 'package:shopaccount/src/layouts/sell/body.dart';
import 'package:shopaccount/src/layouts/stock/Body.dart';
import 'package:shopaccount/src/layouts/user/user.dart';
import 'package:shopaccount/src/models/costLists.dart';
import 'package:shopaccount/src/layouts/products/Body.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onSignedOut;
  const HomeScreen({Key key, this.onSignedOut}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double profit = 0;
    final formatCurrency = NumberFormat.compact();
    final List<Widget> _children = [
      StockScreen(),
      SellScreen(),
      MiscScreen(),
      ReturnScreen(),
      DamageScreen(),
      ProductsScreen(),
    ];
    listfiles.forEach((element) {
      profit += element.perQuantityPrice * element.quantity;
    });
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Home"),
        actions: <Widget>[
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
              setState(() {});
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
                label: 'Stock',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'Sell',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.explicit),
                label: 'Misc.',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.keyboard_return),
                label: 'Return',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.broken_image_outlined),
                label: 'Damage',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'Products',
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
