import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fonty/bloc/user_bloc/user_bloc.dart';
import 'package:fonty/pages/home.dart';
import 'package:fonty/pages/update_password.dart';

enum _ForgetMode { email, code }

class ForgetPasswordScreen extends StatefulWidget {
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();

  final TextEditingController _password = TextEditingController();

  final _bloc = UserBloc();

  var _mode = _ForgetMode.email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 24.0,
              ),
              Container(
                height: 50.0,
                color: Colors.black,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Text(
                  'تغير كلمة المرور',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              _mode == _ForgetMode.email ? _emailfield() : _passwordfield(),
              SizedBox(
                height: 70.0,
              ),
              _submitButton(),
              BlocListener<UserBloc, UserState>(
                bloc: _bloc,
                listener: (context, state) {
                  if (state is Loading) {
                    showDialog(
                      context: context,
                      child: AlertDialog(
                        elevation: 0.0,
                        backgroundColor: Colors.transparent,
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CircularProgressIndicator(),
                          ],
                        ),
                      ),
                    );
                  } else if (state is Error) {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Container(
                          child: Text(state.error),
                        ),
                      ),
                    );
                  } else if (state is Sent) {
                    Navigator.pop(context);
                    setState(() {
                      _mode = _ForgetMode.code;
                    });
                  } else if (state is Authenticated) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  } else if (state is Pass) {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdatePassScreen()));
                  }
                },
                child: Container(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _submitButton() {
    return BlocBuilder<UserBloc, UserState>(
      bloc: _bloc,
      builder: (context, snapshot) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: InkWell(
            onTap: () {
              _formKey.currentState.save();
              if (_formKey.currentState.validate()) {
                print('presssed');
                if (_mode == _ForgetMode.email) {
                  _bloc.add(
                    ForgetPasssword(_email.text),
                  );
                } else {
                  _bloc.add(
                    Code(_password.text),
                  );
                }
              }
            },
            child: Container(
              alignment: Alignment.center,
              height: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color(0xffFABF18)),
              child: Text(
                'ارسال',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      },
    );
  }

  Container _emailfield() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          Text(
            'البريد الالكتروني',
            style: _titleStyle(),
          ),
          SizedBox(
            height: 10.0,
          ),
          TextFormField(
            validator: (val) {
              if (val.isEmpty || !val.contains('@')) {
                return 'please enter a valid email';
              }
            },
            controller: _email,
            decoration: InputDecoration(
              focusedBorder: _inputBorder(),
              enabledBorder: _inputBorder(),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 5, horizontal: 10.0),
              border: _inputBorder(),
            ),
          )
        ],
      ),
    );
  }

  Container _passwordfield() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          Text(
            'ادخل الكود',
            style: _titleStyle(),
          ),
          SizedBox(
            height: 10.0,
          ),
          TextFormField(
            validator: (val) {
              if (val.isEmpty) {
                return 'please enter a valid password';
              }
            },
            controller: _password,
            decoration: InputDecoration(
              focusedBorder: _inputBorder(),
              enabledBorder: _inputBorder(),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 5, horizontal: 10.0),
              border: _inputBorder(),
            ),
          )
        ],
      ),
    );
  }

  TextStyle _titleStyle() => TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
      );

  OutlineInputBorder _inputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: Colors.black),
    );
  }
}
