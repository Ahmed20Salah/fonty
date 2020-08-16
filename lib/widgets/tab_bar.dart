import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fonty/models/item.dart';
import 'package:fonty/pages/description.dart';
import 'package:fonty/pages/home.dart';
import 'package:fonty/repository/home_repo.dart';
import 'package:fonty/utilits/constant.dart';

class CustomTabBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CustomTabBarState();
  }
}

class _CustomTabBarState extends State<CustomTabBar> {
  final HomeRepository homeRepository = HomeRepository();
  final ConstantData constantData = ConstantData();

  List<Item> items = [];
  int selected = 0;
  Item _data = Item(
      name: 'برجر',
      description: 'سلاطه + لحمه + طحينه + سلاطه +لحمه + طحينه',
      price: 12,      image: 'assets/photo.jpg');
  @override
  void initState() {
    super.initState();
    if (homeRepository.categories.length > 0)
      items = homeRepository.categories[0].items;
  }

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
        itemCount: homeRepository.categories.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                items = homeRepository.categories[index].items;
                selected  = index;
              });
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              constraints: BoxConstraints(minWidth: 100.0),
              child: Text(
                homeRepository.categories[index].name,
                style: TextStyle(color:selected == index ? Color(0xffFABF18) :  Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _listingItems() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      height: MediaQuery.of(context).size.height - 313.0,
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return _item(items[index]);
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
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        '${constantData.url}/public/items/${data.image}'),
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
