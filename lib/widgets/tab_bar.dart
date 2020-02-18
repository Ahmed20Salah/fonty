import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fonty/models/item.dart';
import 'package:fonty/pages/description.dart';

class CustomTabBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CustomTabBarState();
  }
}

class _CustomTabBarState extends State<CustomTabBar> {
  Item _data = Item(
      name: 'برجر',
      description: 'سلاطه + لحمه + طحينه + سلاطه +لحمه + طحينه',
      price: 12.5,
      image: 'assets/photo.jpg');

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[_tabBar(), _listingItems()],
      ),
    );
  }

  Widget _tabBar() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      color: Colors.black,
      height: 45.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            constraints: BoxConstraints(minWidth: 100.0),
            child: Text(
              index.toString(),
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      ),
    );
  }

  Widget _listingItems() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      height: MediaQuery.of(context).size.height - 383.0,
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return _item(_data);
        },
      ),
    );
  }

  Widget _item(Item data) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Description(
              item: data,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        height: 110.0,
        child: Container(
          child: Row(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                width: 120.0,
                height: 100.0,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(data.image),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width - 165.0,
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data.name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      'السعر : ${data.price}',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      'المكونات : ${data.description}',
                      maxLines: 3,
                      softWrap: true,
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
