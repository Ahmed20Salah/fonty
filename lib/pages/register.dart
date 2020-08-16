import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fonty/bloc/user_bloc/user_bloc.dart';
import 'package:fonty/pages/home.dart';

class RegisterScrren extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();

  final TextEditingController _password = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _cpassword = TextEditingController();
  final _bloc = UserBloc();
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
                  'تسجيل الدخول',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              _namefield(),
              _emailfield(),
              _phonefield(),
              _passwordfield(),
              _confirmPasswordfield(),
              SizedBox(
                height: 70.0,
              ),
              _submitButton(),
              SizedBox(
                height: 40.0,
              ),
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
                      Navigator.pop(context);
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Container(
                            alignment: Alignment.center,
                            height: 20.0,
                            child: Text(state.error),
                          ),
                        ),
                      );
                    } else if (state is Authenticated) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                    }
                  },
                  child: Container())
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
                  _bloc.add(
                    Register({
                      'name': _name.text,
                      'email': _email.text,
                      'password': _password.text,
                      'phone': _phone.text
                    }),
                  );
                }
              },
              child: Container(
                alignment: Alignment.center,
                height: 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xffFABF18)),
                child: Text(
                  'تسجيل الدخول',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        });
  }

  Container _phonefield() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          Text(
            'رقم الجوال',
            style: _titleStyle(),
          ),
          SizedBox(
            height: 10.0,
          ),
          TextFormField(
            validator: (val) {
              if (val.isEmpty) {
                return 'يرجي ادخال رقم جوال صحيح';
              }
            },
            controller: _phone,
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
                return 'يرجي ادخال ايميل صحيح';
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

  Container _namefield() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          Text(
            'الاسم',
            style: _titleStyle(),
          ),
          SizedBox(
            height: 10.0,
          ),
          TextFormField(
            validator: (val) {
              if (val.isEmpty) {
                return 'يرجي ادخال اسم صحيح';
              }
            },
            controller: _name,
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
            'كلمة المرور',
            style: _titleStyle(),
          ),
          SizedBox(
            height: 10.0,
          ),
          TextFormField(
            obscureText: true,
            validator: (val) {
              if (val.isEmpty) {
                return 'يرجي ادخال كلمه مرور';
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

  Container _confirmPasswordfield() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          Text(
            'تاكيد كلمة المرور ',
            style: _titleStyle(),
          ),
          SizedBox(
            height: 10.0,
          ),
          TextFormField(
            obscureText: true,
            validator: (val) {
              if (val != _password.text) {
                return 'كلمه المرور لا تطابق';
              }
            },
            controller: _cpassword,
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
