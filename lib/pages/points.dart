import 'package:flutter/material.dart';
import 'package:fonty/models/appBarMode.dart';
import 'package:fonty/models/bottom_bar_mode.dart';
import 'package:fonty/widgets/appbar.dart';
import 'package:fonty/widgets/bottom_navigation.dart';

class Points extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF6F6F6),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              CustomAppBar(
                title: 'النقاط',
                mode: Mode.anyPage,
              ),
              Container(
                height: MediaQuery.of(context).size.height - 70.0,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: <Widget>[
                    Text(
                      '55',
                      style: TextStyle(
                          fontSize: 50.0, fontWeight: FontWeight.bold),
                    ),
                    Text('مجموع النقاط')
                  ],
                ),
              )
            ],
          ),
          CustomNavigationBar(mode: PageActive.Points)
        ],
      ),
    );
  }
}
