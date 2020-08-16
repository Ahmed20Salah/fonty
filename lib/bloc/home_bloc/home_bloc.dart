import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:fonty/bloc/user_bloc/user_bloc.dart';
import 'package:fonty/repository/home_repo.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  HomeState get initialState => HomeInitial();
  HomeRepository _homeRepository = HomeRepository();
  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is GetHomeData) {
      yield Loading();
      var re = await _homeRepository.getHomeData();
      print(re);
      if (re['status']) {
        yield HaveHomeData();
      } else {
        yield Error(error: re['error']);
      }
    } else if (event is AddToCart) {
      yield Loading();
      var re = await _homeRepository.addToCart(event.map);
      print(re);
      if (re['status']) {
        yield ItemAdded();
      } else {
        yield Error(error: re['error']);
      }
    }
  }
}
