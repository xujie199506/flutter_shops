import 'package:flutter/material.dart';
import '../service/service_method.dart';
import '../config/service_url.dart';
import '../model/CategoryBigModel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import '../provide/child_category.dart';
import 'package:provide/provide.dart';
import '../model/CateroryGoodsList.dart';

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
      Provide.value<ChilCategory>(context)
          .getChildCateGory(category[0].bxMallSubDto);
    });
  }

  Widget _LeftInkWell(int index) {
    bool isclick = (index == clide ? true : false);
    return InkWell(
      onTap: () {
        var childList = category[index].bxMallSubDto;
        Provide.value<ChilCategory>(context).getChildCateGory(childList);
        setState(() {
          clide = index;
        });
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
        color: Colors.white,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: chilCategory.childCategoryList.length,
          itemBuilder: (context, index) {
            return _rightInwell(chilCategory.childCategoryList[index]);
          },
        ),
      );
    });
  }

  Widget _rightInwell(BxMallSubDto item) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10, 5, 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12)),
        ),
        child: Text(
          item.mallSubName,
          style: TextStyle(fontSize: ScreenUtil().setSp(32)),
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

class _CatgoryGoodsState extends State<CatgoryGoods> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void initState() {
    _getGoodsList();
    super.initState();
  }

// categoryId:大类ID，字符串类型
// categorySubId : 子类ID，字符串类型，如果没有可以填写空字符串，例如''
// page: 分页的页数，int类型
  void _getGoodsList() async {
    var data = {'categoryId': '4', 'categorySubId': "", 'page': 1};
    await request(servicePath['getMallGoods'], formdata: data).then((val) {
      var decode = json.decode(val);
      print('获取商品列表接口数据' + val);
      CateroryGoodsList cateroryGoodsList = CateroryGoodsList.fromJson(decode);
    });
  }
}
