import 'dart:convert';

import 'package:fonty/models/user.dart';
import 'package:fonty/utilits/constant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  static final _obj = UserRepository._internal();
  UserRepository._internal();
  factory UserRepository() {
    return _obj;
  }

  User user;
  SharedPreferences _preferences;
  ConstantData _data = ConstantData();

  Future<Map> login(map) async {
    try {
      print('login');
      var re = await http.post(
          '${_data.url}/api/auth/login?email=${map['email']}&password=${map['password']}');
      var converted = jsonDecode(re.body);
      print(re.body);
      if (converted['status']) {
        print(converted);
        user = User.fromMap(converted['data']);
        _preferences = await SharedPreferences.getInstance();
        _preferences.setString('email', user.email);
        _preferences.setString('token', user.token);
        _preferences.setInt('id', user.id);
        return {'status': converted['status']};
      }
      return converted;
    } catch (e) {
      print(e);
      return {'status': false, 'error': e};
    }
  }

  register(map) async {
    try {
      var re = await http.post(
          '${_data.url}/api/auth/register?email=${map['email']}&password=${map['password']}&name=${map['name']}&phone=${map['phone']}');
      var converted = jsonDecode(re.body);
      print(converted);
      if (converted['status']) {
        user = User.fromMap(converted['data']);
        _preferences = await SharedPreferences.getInstance();
        _preferences.setString('email', user.email);
        _preferences.setString('token', user.token);
        _preferences.setInt('id', user.id);
        return {'status': converted['status']};
      }
      return converted;
    } catch (e) {
      print(e);
      return {'status': false, 'error': e};
    }
  }

  checkAuth() async {
    _preferences = await SharedPreferences.getInstance();
    user = User.fromMap({
      'id': _preferences.get('id'),
      'email': _preferences.get('email'),
      'token': _preferences.get('token')
    });
    if (user.id != null) {
      print(true);
      return true;
    }
    print(false);
    return false;
  }

  logout() async {
    _preferences = await SharedPreferences.getInstance();
    user = null;
    _preferences = await SharedPreferences.getInstance();
    _preferences.setString('email', null);
    _preferences.setString('token', null);
    _preferences.setInt('id', null);
    print(false);
    return false;
  }

  Future<Map> forgetPasssword(String email) async {
    try {
      print(email);
      user = User.fromMap({'email': email});
      var re = await http.post('${_data.url}/api/auth/forgetpass?email=$email');
      var converted = jsonDecode(re.body);
      print(converted);
      if (converted['status']) {
        return {'status': converted['status']};
      }
      return converted;
    } catch (e) {
      print(e);
      return {'status': false, 'error': e};
    }
  }

  Future<Map> code(String code) async {
    print(code);
    try {
      var re = await http.get('${_data.url}/api/auth/check_user_code/$code');
      var converted = jsonDecode(re.body);
      print(converted);
      if (converted['status']) {
        return {'status': converted['status']};
      }
      return converted;
    } catch (e) {
      print(e);
      return {'status': false, 'error': e};
    }
  }

  Future<Map> updataPass(String newPass) async {
    print(user.email);
    print(newPass);
    try {
      var re = await http.put(
          '${_data.url}/api/auth/update_password?email=${user.email}&password=$newPass');
      var converted = jsonDecode(re.body);
      print(converted);
      if (converted['status']) {
        return {'status': converted['status']};
      }
      return converted;
    } catch (e) {
      print(e);
      return {'status': false, 'error': e};
    }
  }
}
