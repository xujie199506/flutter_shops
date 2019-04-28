import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provide/CartProvide.dart';
import '../model/cartinfo.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import './cart_page/cart_item.dart';
import './cart_page/cart_bottom.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
      ),
      body: FutureBuilder(
        future: _getCartInfo(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: <Widget>[
                Provide<CartProvide>(
                  builder: (context, child, val) {
                    print('更新');
                    List cartList =
                        Provide.value<CartProvide>(context).cartList;
                    return Container(
                      width: ScreenUtil().setWidth(750),
                      padding: EdgeInsets.only(bottom: 76),
                      child: ListView.builder(
                        itemCount: cartList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CartItem(cartList[index]);
                        },
                      ),
                    );
                    ;
                  },
                ),
                Positioned(
                  bottom: 0,
                  child: CartBottom(),
                )
              ],
            );
          } else {
            return Text("data");
          }
        },
      ),
    );
  }

  Future<String> _getCartInfo(BuildContext context) async {
    await Provide.value<CartProvide>(context).getCartInfo();
    return 'end';
  }
}
