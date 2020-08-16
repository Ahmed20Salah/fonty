import 'package:flutter/cupertino.dart';

class Item {
  int id;
  String name;
  String description;
  int price;
  String image;
  int points;
  int dicount;
  Item(
      {@required this.name,
      @required this.description,
      @required this.price,
      @required this.image});
  Item.fromMap(json) {
    this.id = json['id'];
    this.name = json['name'];
    this.description = json['body'];
    this.price = json['price'];
    this.image = json['img'];
    this.points = json['points'];
    this.dicount = json['discount'];
  }
}
