import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fonty/pages/login.dart';
import 'package:fonty/repository/user_repo.dart';

class MenuBar extends StatelessWidget {
  UserRepository _userRepo = UserRepository();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
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
                  alignment: Alignment.center,
                  height: 50.0,
                  child: Text(
                    'سياسه الخصوصيه',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
              InkWell(
                child: Container(
                  height: 50.0,
                  alignment: Alignment.center,
                  child: Text(
                    'الشروط والاحكام',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
              InkWell(
                child: Container(
                  height: 50.0,
                  alignment: Alignment.center,
                  child: Text(
                    'الاسئله الشائعه',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
              InkWell(
                child: Container(
                  child: Text(
                    'عن التطبيق',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
              InkWell(
                child: Container(
                  height: 50.0,
                  alignment: Alignment.center,
                  child: Text(
                    'تواصل معنا',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              _userRepo.logout();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: Container(
              color: Color(0xffFABF18),
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              height: 40.0,
              child: Text(
                'تسجيل الخروج',
                style: TextStyle(fontSize: 15),
              ),
            ),
          )
        ],
      ),
    );
  }
}
