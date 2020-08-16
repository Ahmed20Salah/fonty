part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();
}

class CartInitial extends CartState {
  @override
  List<Object> get props => [];
}

class Loading extends CartState {
  @override
  List<Object> get props => [];
}

class HaveCartData extends CartState {
  @override
  List<Object> get props => [];
}

class HaveOrderData extends CartState {
  @override
  List<Object> get props => [];
}

class OrderAdded extends CartState {
  @override
  List<Object> get props => [];
}

class Error extends CartState {
  final String error;
  Error({@required this.error});
  @override
  List<Object> get props => [];
}
