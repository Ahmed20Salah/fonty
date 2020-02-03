import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fonty/widgets/appbar.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          CustomAppBar(title: 'الرئيسيه',),
          
        ],
      ),
    );
  }
}
