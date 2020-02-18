import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fonty/models/appBarMode.dart';
import 'package:fonty/pages/cart.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final Mode mode;
  CustomAppBar({@required this.title, this.mode});
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(MediaQuery.of(context).size.width, 10.0),
      child: Container(
        height: 50.0,
        color: Colors.black,
        child: Column(
          children: <Widget>[_appBar(context)],
        ),
      ),
    );
  }

  // First Line
  _appBar(context) {
    return Container(
      height: 50.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          mode == Mode.home
              ? IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 30.0,
                  ),
                )
              : IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: null),
          Text(
            title,
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Cart(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // Search bar

}
