import 'package:fonty/models/item.dart';

class CartItem{
  int id;
  Item item;
  CartItem.fromMap(json){
    this.id = json['id'];
    this.item = Item.fromMap(json['item_data']);
  }
}