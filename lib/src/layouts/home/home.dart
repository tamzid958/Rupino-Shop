import 'package:flutter/material.dart';
import 'package:shopaccount/constants.dart';
import 'package:shopaccount/src/layouts/return/body.dart';
import 'package:shopaccount/src/layouts/sell/body.dart';
import 'package:shopaccount/src/layouts/stock/Body.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onSignedOut;
  final String data;
  final String productname;
  const HomeScreen(
      {Key key,
      this.onSignedOut,
      @required this.data,
      @required this.productname})
      : super(key: key);

  @override
  _HomeScreenState createState() =>
      _HomeScreenState(data: data, productname: productname);
}

class _HomeScreenState extends State<HomeScreen> {
  String data, productname;
  _HomeScreenState({this.data, this.productname});
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [
      StockScreen(data: data),
      SellScreen(data: data),
      ReturnScreen(data: data),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(productname),
        actions: [
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
                icon: Icon(Icons.keyboard_return),
                label: 'Return',
              ),
            ],
            currentIndex: _selectedIndex,
            unselectedItemColor: kAshColor,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
