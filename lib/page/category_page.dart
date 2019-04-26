import 'package:flutter/material.dart';
import '../service/service_method.dart';
import '../config/service_url.dart';
import '../model/CategoryBigModel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import '../provide/child_category.dart';
import '../provide/category_goods.dart';
import 'package:provide/provide.dart';
import '../model/CateroryGoodsList.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../routers/application.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CategoryPage extends StatefulWidget {
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("商品分类"),
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
            Column(
              children: <Widget>[rightCategoryNav(), CatgoryGoods()],
            )
          ],
        ),
      ),
    );
  }
}

class LeftCategoryNav extends StatefulWidget {
  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List category = [];
  int clide = 0;

  @override
  void initState() {
    _getCategory();
    _getGoodsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
          border: Border(right: BorderSide(width: 1, color: Colors.black12))),
      child: ListView.builder(
        itemCount: category.length,
        itemBuilder: (context, index) {
          return _LeftInkWell(index);
        },
      ),
    );
  }

  void _getCategory() async {
    await request(servicePath['getCategory']).then((v) {
      print('_getCategory' + v);
      var jsonstr = json.decode(v.toString());
      CategoryBigModel dd = CategoryBigModel.fromJson(jsonstr);
      List data = dd.data;
      setState(() {
        category = data;
      });
      Provide.value<ChilCategory>(context).getChildCateGory(
          category[0].bxMallSubDto, category[0].mallCategoryId);
    });
  }

// categoryId:大类ID，字符串类型
// categorySubId : 子类ID，字符串类型，如果没有可以填写空字符串，例如''
// page: 分页的页数，int类型
  void _getGoodsList({String categoryId}) async {
    var data = {
      'categoryId': categoryId == null ? '4' : categoryId,
      'categorySubId': '',
      'page': 1
    };
    print(data);
    await request(servicePath['getMallGoods'], formdata: data).then((val) {
      var decode = json.decode(val);
      print('获取商品列表接口数据' + val);
      CateroryGoodsList cateroryGoodsList = CateroryGoodsList.fromJson(decode);

      Provide.value<CategoryGoodsListProvide>(context)
          .getGoodsList(cateroryGoodsList.data);
    });
  }

  Widget _LeftInkWell(int index) {
    bool isclick = (index == clide ? true : false);
    return InkWell(
      onTap: () {
        var childList = category[index].bxMallSubDto;
        Provide.value<ChilCategory>(context)
            .getChildCateGory(childList, category[index].mallCategoryId);
        setState(() {
          clide = index;
        });

        var categroyid = category[index].mallCategoryId;
        print(categroyid);
        _getGoodsList(categoryId: categroyid);
      },
      child: Container(
        height: ScreenUtil().setHeight(120),
        padding: EdgeInsets.only(left: 10, top: 16),
        decoration: BoxDecoration(
            color: isclick ? Color.fromRGBO(236, 236, 236, 1) : Colors.white,
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: Text(
          category[index].mallCategoryName,
          style: TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}

class rightCategoryNav extends StatefulWidget {
  @override
  _rightCategoryNavState createState() => _rightCategoryNavState();
}

class _rightCategoryNavState extends State<rightCategoryNav> {
  @override
  Widget build(BuildContext context) {
    return Provide<ChilCategory>(builder: (context, child, chilCategory) {
      return Container(
        height: ScreenUtil().setHeight(100),
        width: ScreenUtil().setWidth(570),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12)),
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: chilCategory.childCategoryList.length,
          itemBuilder: (context, index) {
            return _rightInwell(index, chilCategory.childCategoryList[index]);
          },
        ),
      );
    });
  }

  int falg = 0;

  void _getGoodsList(categorySubId) async {
    var data = {
      'categoryId': Provide.value<ChilCategory>(context).categoryId,
      'categorySubId': categorySubId,
      'page': Provide.value<ChilCategory>(context).page
    };
    print(data);
    await request(servicePath['getMallGoods'], formdata: data).then((val) {
      var decode = json.decode(val);
      print('获取商品列表接口数据' + val);
      CateroryGoodsList cateroryGoodsList = CateroryGoodsList.fromJson(decode);

      Provide.value<CategoryGoodsListProvide>(context)
          .getGoodsList(cateroryGoodsList.data);
    });
  }

  Widget _rightInwell(index, BxMallSubDto item) {
    bool ischick = false;
    ischick = (Provide.value<ChilCategory>(context).childIndex == index
        ? true
        : false);
    return InkWell(
      onTap: () {
        setState(() {
          _getGoodsList(item.mallSubId);
          Provide.value<ChilCategory>(context)
              .changeChildIndex(index, item.mallSubId);
        });
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10, 5, 10),
        child: Text(
          item.mallSubName,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(32),
              color: ischick ? Colors.pink : Colors.black),
        ),
      ),
    );
  }
}

//分类页商品列表
class CatgoryGoods extends StatefulWidget {
  @override
  _CatgoryGoodsState createState() => _CatgoryGoodsState();
}

var scrollController = new ScrollController();

class _CatgoryGoodsState extends State<CatgoryGoods> {
  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
      builder: (context, child, data) {
        try {
          if (Provide.value<ChilCategory>(context).page == 1) {
            //列表位置放到最上边
            scrollController.jumpTo(0);
          }
        } catch (e) {
          print("进入页面第一次");
        }
        return data.childCategoryList == null
            ? Container(
                height: ScreenUtil().setHeight(600),
                child: Center(
                  child: Text("该类目下没有数据"),
                ),
              )
            : Expanded(
                child: Container(
                    width: ScreenUtil().setWidth(570),
                    child: EasyRefresh(
                      refreshFooter: ClassicsFooter(
                          bgColor: Colors.white,
                          textColor: Colors.pink,
                          moreInfoColor: Colors.pink,
                          showMore: true,
                          noMoreText:
                              Provide.value<ChilCategory>(context).noMoreText,
                          moreInfo: '加载中',
                          loadReadyText: '上拉加载',
                          key: _footerKey),
                      loadMore: () async {
                        //异步加载
                        print('上拉加载更多');
                        Provide.value<ChilCategory>(context).addPage();
                        _getMoreGoodsList();
                      },
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: data.childCategoryList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _ListWidght(data.childCategoryList, index);
                        },
                      ),
                    )));
      },
    );
  }

  void _getMoreGoodsList() async {
    var data = {
      'categoryId': Provide.value<ChilCategory>(context).categoryId,
      'categorySubId': Provide.value<ChilCategory>(context).subId,
      'page': Provide.value<ChilCategory>(context).page
    };
    print(data);
    await request(servicePath['getMallGoods'], formdata: data).then((val) {
      var decode = json.decode(val);
      print('获取商品列表接口数据' + val);
      CateroryGoodsList cateroryGoodsList = CateroryGoodsList.fromJson(decode);
      if (cateroryGoodsList.data != null) {
        Provide.value<CategoryGoodsListProvide>(context)
            .addGoodsList(cateroryGoodsList.data);
      } else {
        Provide.value<ChilCategory>(context).changenoMoreText("没有更多");
        Fluttertoast.showToast(
            msg: "已经到底了",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.pink,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }

  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();

  @override
  void initState() {
    super.initState();
  }

  Widget _goodsImage(List newlist, index) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(newlist[index].image),
    );
  }

  Widget _goodsName(List newlist, index) {
    return Container(
      padding: EdgeInsets.all(5),
      width: ScreenUtil().setWidth(250),
      child: Text(
        newlist[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
      ),
    );
  }

  Widget _goodPrice(List newlist, index) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Row(
        children: <Widget>[
          Text(
            '价格：￥${newlist[index].presentPrice}',
            style:
                TextStyle(color: Colors.pink, fontSize: ScreenUtil().setSp(30)),
          ),
          Text(
            '价格：￥${newlist[index].oriPrice}',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(20),
                color: Colors.black26,
                decoration: TextDecoration.lineThrough),
          ),
        ],
      ),
    );
  }

  Widget _ListWidght(List newlist, index) {
    return InkWell(
      onTap: () {
        Application.router
            .navigateTo(context, "/detail?id=${newlist[index].goodsId}");
      },
      child: Container(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: Row(
          children: <Widget>[
            _goodsImage(newlist, index),
            Column(
              children: <Widget>[
                _goodsName(newlist, index),
                _goodPrice(newlist, index)
              ],
            )
          ],
        ),
      ),
    );
  }
}
