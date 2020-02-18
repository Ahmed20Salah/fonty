import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fonty/models/appBarMode.dart';
import 'package:fonty/models/item.dart';
import 'package:fonty/widgets/appbar.dart';
import 'package:fonty/widgets/bottom_navigation.dart';

class Description extends StatefulWidget {
  final Item item;
  Description({@required this.item});
  @override
  State<StatefulWidget> createState() {
    return _Description();
  }
}

class _Description extends State<Description> {
  int count = 1;
  final GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              CustomAppBar(
                title: widget.item.name,
                mode: Mode.anyPage,
              ),
              _picture(),
              SizedBox(
                height: 20.0,
              ),
              _details(),
              SizedBox(
                height: 20.0,
              ),
              _addtoCart()
            ],
          ),
          CustomNavigationBar()
        ],
      ),
    );
  }
// Picture element

  Widget _picture() {
    return Container(
      height: 175,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(widget.item.image),
        ),
      ),
    );
  }

  // details Widget
  Widget _details() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 30.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  widget.item.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text('السعر: ${widget.item.price} ريال'),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'المكونات: ${widget.item.description}',
            softWrap: true,
            maxLines: 3,
          ),
          Container(
            height: 30.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('العدد'),
                IconButton(
                  icon: Icon(
                    Icons.add_circle_outline,
                    color: Colors.black,
                    size: 16,
                  ),
                  onPressed: null,
                ),
                Text(count.toString()),
                IconButton(
                  icon: Icon(
                    Icons.do_not_disturb_on,
                    color: Colors.black,
                    size: 16,
                  ),
                  onPressed: null,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _addtoCart() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xffFABF18),
          ),
          alignment: Alignment.center,
          height: 50,
          child: Text(
            'اضافة اللي سلة المشتريات',
            style: TextStyle(fontSize: 19, color: Colors.black),
          ),
        ),
        onTap: () {
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              backgroundColor: Color(0xffC8C6C6),
              content: Container(
                height: 30.0,
                alignment: Alignment.center,
                child: Text('تم الاضافه الي المشتريات ' , style: TextStyle(color:Colors.black ,fontSize: 16),),
              ),
            ),
          );
        },
      ),
    );
  }
}
