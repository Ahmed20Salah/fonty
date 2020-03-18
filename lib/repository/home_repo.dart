import 'dart:convert';

import 'package:fonty/utilits/constant.dart';
import 'package:http/http.dart' as http;

class HomeRepository {
  static final _obj = HomeRepository._internal();
  factory HomeRepository() {
    return _obj;
  }
  HomeRepository._internal();
  ConstantData _constantData = ConstantData();
  getHomeData() async {
    try {
      var re = await http.get('${_constantData.url}/api/mobile/home_data');
      var converted = jsonDecode(re.body);
      if (converted['status']) {
        print(converted);
      }
    } catch (e) {
      print(e);
    }
  }
}
