import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fonty/bloc/user_bloc/user_bloc.dart';
import 'package:fonty/pages/forget_password.dart';
import 'package:fonty/pages/home.dart';
import 'package:fonty/pages/register.dart';
import 'package:fonty/utilits/constant.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _bloc = UserBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
           Column(
            children: <Widget>[
              Container(
                height: 210,
                width: MediaQuery.of(context).size.height,
                color: ConstantData().red,
              )
            ],
          ),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 125.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 140.0,
                            margin: EdgeInsets.symmetric(horizontal: 80.0),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/sandwitch.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 120.0),
                            child: Text(
                              'مرحبا بك …',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Center(
                            child: Text(
                              'تسجيل الدخول',
                              style: TextStyle(
                                  color: ConstantData().red,
                                  fontSize: 27,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                    input(
                        img: 'assets/email.png',
                        con: _email,
                        val: (val) {
                          if (val.isEmpty || !val.contains('@')) {
                            return 'يرجي ادخال ايميل صحيح';
                          }
                        },
                        title: 'البريد الالكتروني'),
                    SizedBox(
                      height: 10.0,
                    ),
                    input(
                        img: 'assets/lock.png',
                        con: _password,
                        password: true,
                        val: (val) {
                          if (val.isEmpty) {
                            return 'يرجي ادخال كلمه سر صحيح';
                          }
                        },
                        title: 'كلمة المرور'),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ForgetPasswordScreen()));
                        },
                        child: Text(' نسيت كلمة المرور؟', style: _titleStyle()),
                      ),
                    ),
                    SizedBox(height: 40.0),
                    _submitButton(),
                    SizedBox(
                      height: 25.0,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterScrren()));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 53,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: ConstantData().black),
                          child: Text(
                            'تسجيل حساب جديد',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
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
                                  height: 20.0,
                                  alignment: Alignment.center,
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
          ),
        ],
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
                    Login({'email': _email.text, 'password': _password.text}),
                  );
                }
              },
              child: Container(
                alignment: Alignment.center,
                height: 53,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: ConstantData().yellow),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      'تسجيل الدخول',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 80.0,
                    ),
                    Icon(Icons.arrow_forward),
                    SizedBox(
                      width: 40.0,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
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
                return 'يرجي ادخال كلمه مرور ';
              }
            },
            controller: _password,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.red),
              ),
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
        fontSize: 16,
        fontWeight: FontWeight.w600,
      );
}

Widget input(
    {String title,
    bool password = false,
    TextEditingController con,
    String img,
    Function val}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 5.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 10.0,
        ),
        Row(
          children: <Widget>[
            Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: ConstantData().red),
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              title,
              style: _titleStyle(),
            ),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
            validator: val,
            controller: con,
            obscureText: password,
            decoration: InputDecoration(
              filled: true,
              fillColor: ConstantData().gray,
              prefixIcon: Image.asset(
                img,
                height: 20.0,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.red),
              ),
              enabledBorder: _inputBorder(),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 5, horizontal: 10.0),
              border: _inputBorder(),
            ),
          ),
        )
      ],
    ),
  );
}

OutlineInputBorder _inputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: Colors.black),
  );
}

TextStyle _titleStyle() => TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );
