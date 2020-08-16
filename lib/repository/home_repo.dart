import 'dart:convert';

import 'package:fonty/models/cart_item.dart';
import 'package:fonty/models/category.dart';
import 'package:fonty/models/item.dart';
import 'package:fonty/models/order.dart';
import 'package:fonty/repository/user_repo.dart';
import 'package:fonty/utilits/constant.dart';
import 'package:http/http.dart' as http;

class HomeRepository {
  static final _obj = HomeRepository._internal();
  factory HomeRepository() {
    return _obj;
  }
  HomeRepository._internal();
  UserRepository _userRepository = UserRepository();

  ConstantData _constantData = ConstantData();
  List<String> slider;
  List<Category> categories;
  double total = 0;
  List<CartItem> cartData = [];
  List<Order> orders = [];

  getHomeData() async {
    try {
      var re = await http.get('${_constantData.url}/api/mobile/home_data');
      var converted = jsonDecode(re.body);
      print(converted);
      if (converted['status']) {
        slider = [];
        for (var item in converted['data']['slider']) {
          slider.add(item['name']);
        }
        categories = [];
        for (var item in converted['data']['categories']) {
          categories.add(Category.fromMap(item));
        }
      }
      return {'status': true, 'error': null};
    } catch (e) {
      return {'status': false, 'error': e};
    }
  }

  addToCart(Map data) async {
    try {
      var re = await http.post(
          '${_constantData.url}/api/mobile/add_to_cart?user_id=${_userRepository.user.id}&item_id=${data['item'].id}&count=${data['count']}');
      var converted = jsonDecode(re.body);
      print(converted);
      if (converted['status']) {
        return {'status': true, 'error': null};
      }

      return converted;
    } catch (e) {
      return {'status': false, 'error': e};
    }
  }

  getCartData() async {
    try {
      var re = await http.get(
          '${_constantData.url}/api/mobile/all_cart/${_userRepository.user.id}');
      var converted = jsonDecode(re.body);
      print(converted);
      total = 0;
      cartData = [];
      if (converted['status']) {
        for (var item in converted['data']) {
          cartData.add(CartItem.fromMap(item));
          total += item['item_data']['price'];
        }
      }
      return {'status': true, 'error': null};
    } catch (e) {
      return {'status': false, 'error': e};
    }
  }

  makeOrder() async {
    print('make order');
    try {
      var re = await http.post(
          '${_constantData.url}/api/mobile/make_order?user_id=${_userRepository.user.id}&payment_type=0');
      var converted = jsonDecode(re.body);
      print(converted);
      if (converted['status']) {
        return {'status': true, 'error': null};
      }
      return converted;
    } catch (e) {
      return {'status': false, 'error': e};
    }
  }

  getOrdersData() async {
    try {
      var re = await http.get(
          '${_constantData.url}/api/mobile/view_orders/${_userRepository.user.id}');
      var converted = jsonDecode(re.body);
      print(converted);
      total = 0;
      if (converted['status']) {
        for (var item in converted['data']) {
          orders.add(Order.fromMap(item));
        }
      }
      return {'status': true, 'error': null};
    } catch (e) {
      return {'status': false, 'error': e};
    }
  }

  deleteItem(int id) async {
    try {
      var re = await http
          .delete('${_constantData.url}/api/mobile/delete_item_from_cart/$id');
      var converted = jsonDecode(re.body);
      print(converted);

      // return converted;
      return {'status': true, 'error': null};
    } catch (e) {
      return {'status': false, 'error': e};
    }
  }
}
