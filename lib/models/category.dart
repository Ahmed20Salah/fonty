import 'package:flutter/cupertino.dart';
import 'package:fonty/models/item.dart';
import 'package:http/http.dart';

class Category {
  int id;
  String name;
  List<Item> items = [];
  Category({@required this.id, @required this.name, @required this.items});
  Category.fromMap(json) {
    this.id = json['id'];
    this.name = json['name'];

    for (var item in json['items']) {
      items.add(Item.fromMap(item));
    }
  }
}
