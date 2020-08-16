import 'package:fonty/models/item.dart';

class Order{
  int id;
  int total;
  List<Item> items = [];
  DateTime date;
  Order.fromMap(json){
    this.id = json['id'];
    this.total = json['total_price'];
    for (var item in json['order_items']) {
      items.add(Item.fromMap(item['item_data']));
    }
    date = DateTime.parse(json['created_at']);
  }
}