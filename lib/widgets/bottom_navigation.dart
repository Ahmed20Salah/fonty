import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fonty/models/bottom_bar_mode.dart';
import 'package:fonty/pages/orders.dart';

class CustomNavigationBar extends StatelessWidget {
  PageActive mode;
  CustomNavigationBar({this.mode});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        color: Colors.black,
        height: 35.0,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width / 2 - .5,
              height: 35.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.device_unknown,
                      color: mode == PageActive.Points
                          ? Color(0xffFABF18)
                          : Colors.white),
                  SizedBox(
                    width: 6.0,
                  ),
                  Container(
                    child: Text(
                      'النقاط',
                      style: TextStyle(
                        color: mode == PageActive.Points
                            ? Color(0xffFABF18)
                            : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              margin: EdgeInsets.symmetric(vertical: 5),
              width: 1.0,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Orders(),
                  ),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 2 - .5,
                height: 35.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.description,
                        color: mode == PageActive.Orders
                            ? Color(0xffFABF18)
                            : Colors.white),
                    SizedBox(
                      width: 6.0,
                    ),
                    Container(
                      child: Text(
                        'الطلبات',
                        style: TextStyle(
                            color: mode == PageActive.Orders
                                ? Color(0xffFABF18)
                                : Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
