part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class GetHomeData extends HomeEvent {
  @override
  List<Object> get props => [];
}

class AddToCart extends HomeEvent {
  final Map map;
  AddToCart({@required this.map});
  @override
  List<Object> get props => [];
}
