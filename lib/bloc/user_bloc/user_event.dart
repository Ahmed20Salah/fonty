part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class Login extends UserEvent {
  final Map userdata;
  Login(this.userdata);
  @override
  List<Object> get props => [];
}

class Register extends UserEvent {
  final Map userdata;
  Register(this.userdata);
  @override
  List<Object> get props => [];
}

class ForgetPasssword extends UserEvent {
  final String email;
  ForgetPasssword(this.email);
  @override
  List<Object> get props => [];
}

class Code extends UserEvent {
  final String code;
  Code(this.code);
  @override
  List<Object> get props => [];
}

class Updata extends UserEvent {
  final String pass;
  Updata(this.pass);
  @override
  List<Object> get props => [];
}

class Checking extends UserEvent {
  @override
  List<Object> get props => [];
}
