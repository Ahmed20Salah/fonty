import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fonty/bloc/cart_bloc/cart_bloc.dart';
import 'package:fonty/models/appBarMode.dart';
import 'package:fonty/models/cart_item.dart';
import 'package:fonty/models/item.dart';
import 'package:fonty/pages/home.dart';
import 'package:fonty/repository/home_repo.dart';
import 'package:fonty/utilits/constant.dart';
import 'package:fonty/widgets/appbar.dart';

class Cart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CartState();
  }
}

class _CartState extends State<Cart> {
  int count = 1;
  HomeRepository _homeRepository = HomeRepository();
  final CartBloc _cartBloc = CartBloc();
  final ConstantData constantData = ConstantData();
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  void initState() {
    _cartBloc.add(GetCart());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      backgroundColor: Color(0xffF6F6F6),
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              CustomAppBar(
                title: 'سلة المشتريات',
                mode: Mode.anyPage,
              ),
              SizedBox(
                height: 20.0,
              ),
              BlocConsumer(
                  listener: (prev, state) {
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
                      _globalKey.currentState.showSnackBar(
                        SnackBar(
                          content: Container(
                            height: 20.0,
                            alignment: Alignment.center,
                            child: Text(state.error),
                          ),
                        ),
                      );
                    } else if (state is OrderAdded) {
                      Navigator.pop(context);
                      _globalKey.currentState.showSnackBar(
                        SnackBar(
                          content: Container(
                            height: 20.0,
                            alignment: Alignment.center,
                            child: Text('Order Added Successfully'),
                          ),
                        ),
                      );
                    } else if (state is HaveCartData) {
                      Navigator.pop(context);
                    }
                  },
                  bloc: _cartBloc,
                  builder: (context, state) {
                    print(state);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _listingItems(),
                        _total(),
                      ],
                    );
                  }),
              // _payment()
            ],
          ),
          _customBottomBar()
        ],
      ),
    );
  }

  // items Listing
  Widget _listingItems() {
    return Container(
      height: 400.0,
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      padding: EdgeInsets.symmetric(vertical: 10.0),
      color: Colors.white,
      child: ListView.builder(
        itemCount: _homeRepository.cartData.length,
        itemBuilder: (context, index) {
          return _item(_homeRepository.cartData[index], index);
        },
      ),
    );
  }

// Item
  Widget _item(CartItem item, index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      height: 100.0,
      child: Row(
        children: <Widget>[
          Container(
            width: 100.0,
            decoration: BoxDecoration(
              border: Border.all(width: 2),
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                image: NetworkImage(
                    '${constantData.url}/public/items/${item.item.image}'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 30.0,
                  width: MediaQuery.of(context).size.width - 170.0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '${item.item.name}',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _homeRepository.total -= item.item.price;
                            _homeRepository.cartData.removeAt(index);
                            _cartBloc.add(DeleteItem(id: item.id));
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              border: Border.all(), shape: BoxShape.circle),
                          child: (Icon(
                            Icons.close,
                            size: 15,
                          )),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 40.0,
                  width: 120.0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'الكميه: ',
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      // InkWell(
                      //   child: Icon(
                      //     Icons.add,
                      //     size: 20.0,
                      //     color: Color(0xffFABF18),
                      //   ),
                      // ),
                      Text('1'),
                      // InkWell(
                      //   child: Container(
                      //     color: Color(0xffFABF18),
                      //     height: 3,
                      //     width: 10,
                      //   ),
                      // )
                    ],
                  ),
                ),
                Container(
                  height: 29.0,
                  width: MediaQuery.of(context).size.width - 180,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'السعر: ${item.item.price}ريال',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

// total bar

  Widget _total() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Text(
        'المجموع: ${_homeRepository.total} ريال',
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

// payment box
  Widget _payment() {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        constraints: BoxConstraints(maxHeight: 355.0),
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'طريقة الدفع',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

// bottom bar
  Widget _customBottomBar() {
    return Positioned(
      bottom: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        height: 60.0,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            InkWell(
              onTap: () {
                _cartBloc.add(AddOrder());
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Color(0xffFABF18),
                ),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width / 2 - 30.5,
                height: 35.0,
                child: Container(
                  child: Text(
                    'تنفيذ الطلب',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(7),
                ),
                width: MediaQuery.of(context).size.width / 2 - 30.5,
                height: 35.0,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    'اضافة المزيد',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
