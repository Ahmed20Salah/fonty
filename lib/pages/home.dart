import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fonty/models/appBarMode.dart';
import 'package:fonty/widgets/appbar.dart';
import 'package:fonty/widgets/bottom_navigation.dart';
import 'package:fonty/widgets/menu.dart';
import 'package:fonty/widgets/search.dart';
import 'package:fonty/widgets/silder.dart';
import 'package:fonty/widgets/tab_bar.dart';

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
      drawer: MenuBar(),
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              CustomAppBar(
                title: 'الرئيسيه',
                mode: Mode.home,
              ),
              Search(),
              CustomSlider(),
              CustomTabBar()
            ],
          ),
          CustomNavigationBar()
        ],
      ),
    );
  }
}
