class CateroryGoodsList {
  String _code;
  String _message;
  List<Data> _data;

  CateroryGoodsList({String code, String message, List<Data> data}) {
    this._code = code;
    this._message = message;
    this._data = data;
  }

  String get code => _code;
  set code(String code) => _code = code;
  String get message => _message;
  set message(String message) => _message = message;
  List<Data> get data => _data;
  set data(List<Data> data) => _data = data;

  CateroryGoodsList.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = new List<Data>();
      json['data'].forEach((v) {
        _data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this._code;
    data['message'] = this._message;
    if (this._data != null) {
      data['data'] = this._data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String _image;
  double _oriPrice;
  double _presentPrice;
  String _goodsName;
  String _goodsId;

  Data(
      {String image,
      double oriPrice,
      double presentPrice,
      String goodsName,
      String goodsId}) {
    this._image = image;
    this._oriPrice = oriPrice;
    this._presentPrice = presentPrice;
    this._goodsName = goodsName;
    this._goodsId = goodsId;
  }

  String get image => _image;
  set image(String image) => _image = image;
  double get oriPrice => _oriPrice;
  set oriPrice(double oriPrice) => _oriPrice = oriPrice;
  double get presentPrice => _presentPrice;
  set presentPrice(double presentPrice) => _presentPrice = presentPrice;
  String get goodsName => _goodsName;
  set goodsName(String goodsName) => _goodsName = goodsName;
  String get goodsId => _goodsId;
  set goodsId(String goodsId) => _goodsId = goodsId;

  Data.fromJson(Map<String, dynamic> json) {
    _image = json['image'];
    _oriPrice = json['oriPrice'];
    _presentPrice = json['presentPrice'];
    _goodsName = json['goodsName'];
    _goodsId = json['goodsId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this._image;
    data['oriPrice'] = this._oriPrice;
    data['presentPrice'] = this._presentPrice;
    data['goodsName'] = this._goodsName;
    data['goodsId'] = this._goodsId;
    return data;
  }
}
