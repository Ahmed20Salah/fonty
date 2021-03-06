import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fonty/bloc/cart_bloc/cart_bloc.dart';
import 'package:fonty/models/appBarMode.dart';
import 'package:fonty/models/bottom_bar_mode.dart';
import 'package:fonty/models/order.dart';
import 'package:fonty/repository/home_repo.dart';
import 'package:fonty/widgets/appbar.dart';
import 'package:fonty/widgets/bottom_navigation.dart';

class Orders extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OrdersState();
  }
}

class _OrdersState extends State<Orders> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final CartBloc _bloc = CartBloc();
  HomeRepository _homeRepository = HomeRepository();

  @override
  void initState() {
    super.initState();
    _bloc.add(GetOrder());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xffF6F6F6),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              CustomAppBar(
                title: 'الطلبات',
                mode: Mode.anyPage,
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
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Container(
                            height: 20.0,
                            alignment: Alignment.center,
                            child: Text(state.error),
                          ),
                        ),
                      );
                    } else if (state is HaveOrderData) {
                      Navigator.pop(context);
                    }
                  },
                  bloc: _bloc,
                  builder: (context, state) {
                    return _listingItems();
                  })
            ],
          ),
          CustomNavigationBar(mode: PageActive.Orders)
        ],
      ),
    );
  }

// listing items
  Widget _listingItems() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      height: MediaQuery.of(context).size.height - 110,
      child: ListView.builder(
        itemCount: _homeRepository.orders.length,
        itemBuilder: (context, index) {
          return _item(_homeRepository.orders[index]);
        },
      ),
    );
  }

// item
  Widget _item(Order order) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      margin: EdgeInsets.only(bottom: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              '  ${order.date.year}/ ${order.date.month}/${order.date.day}',
              style: TextStyle(fontSize: 12),
            ),
          ),
          Text(
            'رقم الطلب: ${order.id}',
            style: TextStyle(fontSize: 14),
          ),
          Text(
            '${order.items[0].name}',
            overflow: TextOverflow.fade,
            softWrap: false,
            style: TextStyle(fontSize: 14),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'المجموع: ${order.total}ريال',
                overflow: TextOverflow.fade,
                softWrap: false,
                style: TextStyle(fontSize: 14),
              ),
              _reorderButton()
            ],
          ),
        ],
      ),
    );
  }

  // reorder button
  Widget _reorderButton() {
    return InkWell(
      child: Container(
        height: 25,
        width: 110,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color(0xffF6F6F6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.restore,
              size: 20.0,
            ),
            SizedBox(
              width: 5.0,
            ),
            Text('اعادة الطلب'),
          ],
        ),
      ),
      onTap: () {
        _orderConfirm();
      },
    );
  }

  Future _orderConfirm() {
    return showDialog(
      context: context,
      child: AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.all(0),
        content: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          height: 100.0,
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Text('تاكيد طلبك'),
              SizedBox(
                height: 20.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);

                        _scaffoldKey.currentState.showSnackBar(
                          SnackBar(
                            backgroundColor: Color(0xffC8C6C6),
                            content: Container(
                              height: 30.0,
                              alignment: Alignment.center,
                              child: Text(
                                'تم اراسال طلبك بنجاح رقم الطلب 00000',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 70.0,
                        decoration: BoxDecoration(
                          color: Color(0xffFABF18),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          'موافق',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 70.0,
                        decoration: BoxDecoration(
                          color: Color(0xffC8C6C6),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text('الالغاء'),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
