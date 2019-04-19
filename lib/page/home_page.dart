import 'package:flutter/material.dart';
import '../service/service_method.dart';
import '../config/service_url.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
// import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  String homePageContent = '正在获取远端数据';

  int page = 1;
  List<Map> hotGoodsList = [];

  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();

  void initState() {
    super.initState();
    _getHotGoods();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('卖酒的'),
      ),
      body: FutureBuilder(
        future: getHomePageContent(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = json.decode(snapshot.data.toString());
            List<Map> swiper = (data['data']['slides'] as List).cast();
            List<Map> navigatorList = (data['data']['category'] as List).cast();
            String AdPicture =
                data['data']['advertesPicture']['PICTURE_ADDRESS'];
            String leaderImage = data['data']['shopInfo']['leaderImage']; //店长图片
            String leaderPhone = data['data']['shopInfo']['leaderPhone']; //店长电话
            List<Map> recommendList =
                (data['data']['recommend'] as List).cast();

            String floor1Title =
                data['data']['floor1Pic']['PICTURE_ADDRESS']; //楼层1的标题图片
            String floor2Title =
                data['data']['floor2Pic']['PICTURE_ADDRESS']; //楼层1的标题图片
            String floor3Title =
                data['data']['floor3Pic']['PICTURE_ADDRESS']; //楼层1的标题图片
            List<Map> floor1 =
                (data['data']['floor1'] as List).cast(); //楼层1商品和图片
            List<Map> floor2 =
                (data['data']['floor2'] as List).cast(); //楼层1商品和图片
            List<Map> floor3 =
                (data['data']['floor3'] as List).cast(); //楼层1商品和图片
            return EasyRefresh(
                refreshFooter: ClassicsFooter(
                    bgColor: Colors.white,
                    textColor: Colors.pink,
                    moreInfoColor: Colors.pink,
                    showMore: true,
                    noMoreText: '',
                    moreInfo: '加载中',
                    loadReadyText: '上拉加载',
                    key: _footerKey),
                loadMore: () async {
                  //异步加载
                  print('开始加载。。');
                  var formPage = {'page': page};
                  request(servicePath['homePaeBelowConten'], formdata: formPage)
                      .then((v) {
                    var data = json.decode(v.toString());
                    List<Map> newHotGoods = (data['data'] as List).cast();
                    setState(() {
                      hotGoodsList.addAll(newHotGoods);
                      page++;
                    });
                  });
                },
                child: ListView(
                  children: <Widget>[
                    SwiperDiy(swiperData: swiper),
                    TopNavigator(navigatorList: navigatorList),
                    AdBanner(adPicture: AdPicture),
                    LaderPhone(
                        laderPhone: leaderPhone, laderPitrue: leaderImage),
                    Recommend(recommendList: recommendList),
                    FloorTitle(pic_url: floor1Title),
                    FloorContent(floorGoodsList: floor1),
                    FloorTitle(pic_url: floor2Title),
                    FloorContent(floorGoodsList: floor2),
                    FloorTitle(pic_url: floor3Title),
                    FloorContent(floorGoodsList: floor3),
                    _hotGoods()
                  ],
                ));
          } else {
            return Center(
              child: Text("加载中"),
            );
          }
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  void _getHotGoods() {
    var formPage = {'page': page};
    request(servicePath['homePaeBelowConten'], formdata: formPage).then((v) {
      var data = json.decode(v.toString());
      List<Map> newHotGoods = (data['data'] as List).cast();
      setState(() {
        hotGoodsList.addAll(newHotGoods);
        page++;
      });
    });
  }

  Widget _hottitle = Container(
    margin: EdgeInsets.all(10.0),
    alignment: Alignment.center, //对齐方式
    color: Colors.transparent,

    child: Text('火爆专区'),
  );
  Widget _wrapList() {
    if (hotGoodsList.length != 0) {
      List<Widget> listWidgets = hotGoodsList.map((val) {
        return InkWell(
            onTap: () {},
            child: Container(
              width: ScreenUtil().setWidth(372),
              color: Colors.white,
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.only(bottom: 3),
              child: Column(
                children: <Widget>[
                  Image.network(val['image'],
                      width: ScreenUtil().setWidth(370)),
                  Text(
                    val['name'],
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.pink, fontSize: ScreenUtil().setSp(26)),
                  ),
                  Row(
                    children: <Widget>[
                      Text('￥${val['mallPrice']}'),
                      Text(
                        '￥${val['price']}',
                        style: TextStyle(
                            color: Colors.black26,
                            decoration: TextDecoration.underline),
                      )
                    ],
                  )
                ],
              ),
            ));
      }).toList();

      return Wrap(
        //流式布局
        spacing: 2, //m每一行两列
        children: listWidgets,
      );
    } else {
      return Text('');
    }
  }

  Widget _hotGoods() {
    return Container(
      child: Column(
        children: <Widget>[_hottitle, _wrapList()],
      ),
    );
  }
}

//轮播组建
class SwiperDiy extends StatelessWidget {
  final List<Map> swiperData;

  SwiperDiy({Key key, this.swiperData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext cntext, int index) {
          return Image.network(
            "${swiperData[index]['image']}",
            fit: BoxFit.fill,
          );
        },
        itemCount: swiperData.length,
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

//gridview类别导航制作
class TopNavigator extends StatelessWidget {
  final List navigatorList;

  TopNavigator({Key key, this.navigatorList}) : super(key: key);

  Widget _gridViewItem(BuildContext context, item) {
    return InkWell(
      onTap: () {
        print("点击了导航");
      },
      child: Column(
        children: <Widget>[
          Image.network(item['image'], width: ScreenUtil().setWidth(95)),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (navigatorList.length > 10) {
      navigatorList.removeRange(10, navigatorList.length);
    }

    return Container(
        padding: EdgeInsets.all(3.0),
        height: ScreenUtil().setHeight(320),
        child: GridView.count(
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 5,
            padding: EdgeInsets.all(5.0),
            children: navigatorList.map((item) {
              return _gridViewItem(context, item);
            }).toList()));
  }
}

//广告
class AdBanner extends StatelessWidget {
  final String adPicture;

  AdBanner({Key key, this.adPicture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
      child: Image.network(adPicture),
    );
  }
}

//打电话
class LaderPhone extends StatelessWidget {
  final String laderPhone;
  final String laderPitrue;

  LaderPhone({Key key, this.laderPhone, this.laderPitrue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          // launcherURL();
        },
        child: Image.network(this.laderPitrue),
      ),
    );
  }

  // void launcherURL() async {
  //   String url = 'tel:' + this.laderPhone;
  //   if (await canLaunch(url)) {
  //     print('开始打电话');
  //     await launch(url);
  //   } else {
  //     throw 'url错误';
  //   }
  // }
}

//商品推荐
class Recommend extends StatelessWidget {
  final List recommendList;

  Recommend({Key key, this.recommendList}) : super(key: key);

//标题
  Widget _titleWidget() {
    return Container(
      alignment: Alignment.centerLeft, //对齐方式
      padding: EdgeInsets.fromLTRB(10, 2, 0, 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(width: 0.5, color: Colors.black12)),
      ), //样式
      child: Text('商品推荐', style: TextStyle(color: Colors.pink)),
    );
  }

//商品单独项
  Widget _item(index) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: ScreenUtil().setHeight(380),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(left: BorderSide(width: 0.5, color: Colors.black12))),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text('￥${recommendList[index]['mallPrice']}'),
            Text(
              '￥${recommendList[index]['price']}',
              style: TextStyle(
                  decoration: TextDecoration.lineThrough //删除线，用于商城废弃价格（原价）
                  ,
                  color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }

//横向列表
  Widget _recommedList() {
    return Container(
      height: ScreenUtil().setHeight(380),
      child: ListView.builder(
        scrollDirection: Axis.horizontal, //设置listview横向的
        itemCount: recommendList.length, //长度
        itemBuilder: (context, index) {
          return _item(index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(445),
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[_titleWidget(), _recommedList()],
      ),
    );
  }
}

class FloorTitle extends StatelessWidget {
  final String pic_url;

  FloorTitle({Key key, this.pic_url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(1),
      child: InkWell(
        onTap: () {},
        child: Image.network(pic_url),
      ),
    );
  }
}

class FloorContent extends StatelessWidget {
  final List floorGoodsList;

  FloorContent({Key key, this.floorGoodsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[_fristRow(), _otherRow()],
      ),
    );
  }

  Widget _fristRow() {
    return Container(
      child: Row(
        children: <Widget>[
          _gooditem(floorGoodsList[0]),
          Column(
            children: <Widget>[
              _gooditem(floorGoodsList[1]),
              _gooditem(floorGoodsList[2]),
            ],
          )
        ],
      ),
    );
  }

  Widget _otherRow() {
    return Container(
      child: Row(
        children: <Widget>[
          _gooditem(floorGoodsList[3]),
          _gooditem(floorGoodsList[4]),
        ],
      ),
    );
  }

  Widget _gooditem(Map goods) {
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: () {},
        child: Image.network(goods['image']),
      ),
    );
  }
}

//火爆专区数据

class HotGoods extends StatefulWidget {
  _HotGoodsState createState() => _HotGoodsState();
}

class _HotGoodsState extends State<HotGoods> {
  @override
  void initState() {
    super.initState();
    request(servicePath['homePaeBelowConten'], formdata: 1).then((val) {
      print(val);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('data'),
    );
  }
}
