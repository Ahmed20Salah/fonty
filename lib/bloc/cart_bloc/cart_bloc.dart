import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fonty/bloc/user_bloc/user_bloc.dart';
import 'package:fonty/repository/home_repo.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  @override
  CartState get initialState => CartInitial();
  final HomeRepository _homeRepository = HomeRepository();
  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    print(event);
    if (event is GetCart) {
      yield Loading();
      var re = await _homeRepository.getCartData();
      if (re['status']) {
        yield HaveCartData();
      } else {
        yield Error(error: re['error']);
      }
    }else
    if (event is AddOrder) {
      yield Loading();
      var re = await _homeRepository.makeOrder();
      if (re['status']) {
        yield OrderAdded();
      } else {
        yield Error(error: re['error']);
      }
    }else
    if (event is GetOrder) {
      yield Loading();
      var re = await _homeRepository.getOrdersData();
      print(re);

      if (re['status']) {
        yield HaveOrderData();
      } else {
        yield Error(error: re['error']);
      }
    }
    else if(event is DeleteItem){
      yield Loading();
      var re = await _homeRepository.deleteItem(event.id);
      print(re);

      if (re['status']) {
        yield HaveCartData();
      } else {
        yield Error(error: re['errors']);
      }
    }
  }
}
