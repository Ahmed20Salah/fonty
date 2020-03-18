import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fonty/repository/user_repo.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserRepository _userRepository = UserRepository();
  @override
  UserState get initialState => UserInitial();

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    print(event);
    if (event is Login) {
      yield Loading();
      var re = await _userRepository.login(event.userdata);
      if (re['status']) {
        yield Authenticated();
      } else {
        print(re);
        yield Error(re['error']);
      }
    } else if (event is Register) {
      yield Loading();
      var re = await _userRepository.register(event.userdata);
      if (re['status']) {
        yield Authenticated();
      } else {
        yield Error(re['error']);
      }
    } else if (event is ForgetPasssword) {
      yield Loading();
      var re = await _userRepository.forgetPasssword(event.email);
      print(re);
      if (re['status']) {
        yield Sent();
      }
    } else if (event is Code) {
      print(event);
      yield Loading();
      var re = await _userRepository.code(event.code);
      if (re['status']) {
        yield Pass();
      }
    } else if (event is Updata) {
      var re = await _userRepository.updataPass(event.pass);
      if (re['status']) {
        yield Authenticated();
      }
    }
  }
}
