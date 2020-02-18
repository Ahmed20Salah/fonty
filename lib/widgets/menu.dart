import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Container(
            height: 100.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/photo.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          InkWell(
            child: Container(
              child: Text('سياسه الخصوصيه'),
            ),
          ),
          InkWell(
            child: Container(
              child: Text('الشروط والاحكام'),
            ),
          ),
          InkWell(
            child: Container(
              child: Text('الاسئله الشائعه'),
            ),
          ),
               InkWell(
            child: Container(
              child: Text('عن التطبيق'),
            ),
          ),     InkWell(
            child: Container(
              child: Text('تواصل معنا'),
            ),
          ),
        ],
      ),
    );
  }
}
