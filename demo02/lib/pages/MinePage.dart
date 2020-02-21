import 'package:flutter/material.dart';

class MinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('各种控件练手'),
      ),
      body: new Container(
        child: new Column(
          children: <Widget>[
            new Text('button 各种样式'),
            new Row(
                children: <Widget>[
                  Container(
                    child: Center(
                      child: Text( 
                        'ok',
                        style: TextStyle(
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                    width: 90.0,
                    height: 32.0,
                    decoration: new BoxDecoration(
                      color: Color(0xff00aeff), // 底色
                      borderRadius: BorderRadius.all(Radius.circular(16.0)), // 也可控件一边圆角大小
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(width: 1.0, color: Colors.lightBlue.shade50),
                        bottom: BorderSide(width: 1.0, color: Colors.lightBlue.shade900),
                      ),
                    ),
                    child: Text('Flutter in the sky', textAlign: TextAlign.center),
                  ),
                  Container(
                    width: 25.0,
                    height: 25.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: ExactAssetImage('images/home.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
            ),
          ],
        ),
      ),
    );
  }
}