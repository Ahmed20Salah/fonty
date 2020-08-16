part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class Loading extends HomeState {
  @override
  List<Object> get props => [];
}

class Error extends HomeState {
  final String error;
  Error({@required this.error});
  @override
  List<Object> get props => [];
}

class HaveHomeData extends HomeState {
  @override
  List<Object> get props => [];
}
class ItemAdded extends HomeState {
  @override
  List<Object> get props => [];
}

