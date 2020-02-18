import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fonty/models/appBarMode.dart';
import 'package:fonty/widgets/appbar.dart';

class Cart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CartState();
  }
}

class _CartState extends State<Cart> {
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF6F6F6),
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              CustomAppBar(
                title: 'سلة المشتريات',
                mode: Mode.anyPage,
              ),
              SizedBox(
                height: 20.0,
              ),
              _listingItems(),
              _total(),
              _payment()
            ],
          ),
          _customBottomBar()
        ],
      ),
    );
  }

  // items Listing
  Widget _listingItems() {
    return Container(
      height: 250.0,
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      padding: EdgeInsets.symmetric(vertical: 10.0),
      color: Colors.white,
      child: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return _item();
        },
      ),
    );
  }

// Item
  Widget _item() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      height: 100.0,
      child: Row(
        children: <Widget>[
          Container(
            width: 100.0,
            decoration: BoxDecoration(
              border: Border.all(width: 2),
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                image: AssetImage('assets/photo.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'برجر',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 40.0,
                  width: 120.0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'الكميه: ',
                        style: TextStyle(color: Colors.black),
                      ),
                      InkWell(
                        child: Icon(
                          Icons.add,
                          size: 20.0,
                          color: Color(0xffFABF18),
                        ),
                      ),
                      Text('$count'),
                      InkWell(
                        child: Container(
                          color: Color(0xffFABF18),
                          height: 3,
                          width: 10,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 29.0,
                  width: MediaQuery.of(context).size.width - 180,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('السعر: 50ريال'),
                      Text('المجموع: 150ريال')
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

// total bar

  Widget _total() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Text(
        'المجموع الكلي: 500ريال',
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

// payment box
  Widget _payment() {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        constraints: BoxConstraints(maxHeight: 355.0),
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'طريقة الدفع',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            
          ],
        ),
      ),
    );
  }

// bottom bar
  Widget _customBottomBar() {
    return Positioned(
      bottom: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        height: 60.0,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Color(0xffFABF18),
              ),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width / 2 - 30.5,
              height: 35.0,
              child: Container(
                child: Text(
                  'تنفيذ الطلب',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(7),
              ),
              width: MediaQuery.of(context).size.width / 2 - 30.5,
              height: 35.0,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  'اضافة المزيد',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
