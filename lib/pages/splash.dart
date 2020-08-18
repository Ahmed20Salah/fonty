import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fonty/bloc/user_bloc/user_bloc.dart';
import 'package:fonty/pages/home.dart';
import 'package:fonty/pages/login.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  UserBloc _userBloc = UserBloc();
  @override
  void initState() {
    _userBloc.add(Checking());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener(
          listener: (prev, current) {
            print(current);
            if (current is Authenticated) {
              Timer(
                  Duration(
                    seconds: 10,
                  ), () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Home()));
              });
            } else if (current is Unauthenticated) {
              Timer(Duration(seconds: 10), () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              });
            }
          },
          bloc: _userBloc,
          child: Container(
            color: Colors.white,
            // decoration: BoxDecoration(
            // image: DecorationImage(
            //     image: AssetImage('assets/splash.png'), fit: BoxFit.cover)),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset('assets/logo.png'),
          )),
    );
  }
}
