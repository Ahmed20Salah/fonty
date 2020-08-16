part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
}

class GetCart extends CartEvent {
  @override
  List<Object> get props => [];
}

class AddOrder extends CartEvent {
  @override
  List<Object> get props => [];
}

class GetOrder extends CartEvent {
  @override
  List<Object> get props => [];
}

class DeleteItem extends CartEvent {
  final int id;
  DeleteItem({@required this.id});
  @override
  List<Object> get props => [];
}
