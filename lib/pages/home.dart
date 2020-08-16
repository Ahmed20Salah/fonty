import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fonty/bloc/home_bloc/home_bloc.dart';
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
  final HomeBloc homeBloc = HomeBloc();
  @override
  void initState() {
    super.initState();
    homeBloc.add(GetHomeData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuBar(),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            child: BlocConsumer(
                listener: (prev, state) {
                  if (state is Loading) {
                    showDialog(
                      context: context,
                      child: AlertDialog(
                        elevation: 0.0,
                        backgroundColor: Colors.transparent,
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CircularProgressIndicator(),
                          ],
                        ),
                      ),
                    );
                  } else if (state is Error) {
                    Navigator.pop(context);
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Container(
                          height: 20.0,
                          alignment: Alignment.center,
                          child: Text(state.error),
                        ),
                      ),
                    );
                  } else if (state is HaveHomeData) {
                    Navigator.pop(context);
                  }
                },
                bloc: homeBloc,
                builder: (context, state) {
                  print(state);
                  if (state is HaveHomeData) {
                    return ListView(
                      children: <Widget>[
                        CustomAppBar(
                          title: 'الرئيسيه',
                          mode: Mode.home,
                        ),
                        // Search(),
                        CustomSlider(),
                        CustomTabBar()
                      ],
                    );
                  }
                  return Container();
                }),
          ),
          CustomNavigationBar()
        ],
      ),
    );
  }
}
