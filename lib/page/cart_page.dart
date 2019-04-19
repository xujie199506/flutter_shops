import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/counter.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[Mytext(), Mybutton()],
        ),
      ),
    );
  }
}

class Mybutton extends StatefulWidget {
  @override
  _MybuttonState createState() => _MybuttonState();
}

class _MybuttonState extends State<Mybutton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        child: Text("点一下"),
        onPressed: () {
          Provide.value<Counter>(context).increment();
        },
      ),
    );
  }
}

class Mytext extends StatefulWidget {
  @override
  _MytextState createState() => _MytextState();
}

class _MytextState extends State<Mytext> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(22),
      child: Provide<Counter>(
        builder: (context, child, counter) {
          return Text('${counter.value}');
        },
      ),
    );
  }
}
