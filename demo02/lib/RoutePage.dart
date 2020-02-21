import 'dart:async';

import 'package:flutter/material.dart';
import './main.dart';

class RoutePage extends StatefulWidget {
  @override
  _RoutePageState createState () => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  Timer _t;

  @override
  void initState() {
    super.initState();
    _t = new Timer(const Duration(microseconds: 1500), () {
      try{
        Navigator.of(context).pushAndRemoveUntil(
        PageRouteBuilder<Null>(
            pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
              return AnimatedBuilder(
                animation: animation,
                builder: (BuildContext context, Widget child) {
                  return Opacity(
                    opacity: animation.value,
                    child: new Tiger(title: '老虎钳'),
                  );
                },
              );
            },
        ),
        (Route route) => route == null);
      }
      catch(e) {}
    });
  }

  @override
  void dispose() {
    _t.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: new Color.fromARGB(255, 0, 215, 198),
      child: Container(
        alignment: Alignment(0, 0.3),
        child: new Text(
          '老虎钳',
          style: new TextStyle(
            color: Colors.white, fontSize: 50.0, fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}