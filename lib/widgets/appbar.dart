import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  CustomAppBar({@required this.title});
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(MediaQuery.of(context).size.width, 200.0),
      child: Column(
        children: <Widget>[_appBar(), _searchBar()],
      ),
    );
  }

  // First Line
  _appBar() {
    return Container(
      height: 100.0,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart),
          ),
          Text(title),
          IconButton(
            icon: Icon(Icons.menu),
          )
        ],
      ),
    );
  }

  // Search bar

  _searchBar() {
    return Container(
      height: 100.0,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 4),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
        child: TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
            prefix: IconButton(
              icon: Icon(Icons.search),
            ),
          ),
        ),
      ),
    );
  }
}
