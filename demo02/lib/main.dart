import 'package:flutter/material.dart';
import 'pages/HomePage.dart';
import 'pages/OrderPage.dart';
import 'pages/MinePage.dart';
import './layout_type.dart';
import './RoutePage.dart';

void main() {
  runApp(new App());
}

class App extends StatelessWidget {
  App({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primaryIconTheme: const IconThemeData(color: Colors.white),
        brightness: Brightness.light,
        primaryColor: new Color.fromARGB(255, 0, 215, 198),
        accentColor: Colors.cyan[300],
      ),
      home: RoutePage(),
    );
  }
}

class Tiger extends StatefulWidget {
  final String title;
  Tiger({Key key, this.title}) : super(key: key);
  @override
  _TigerState createState() => new _TigerState();
}

class _TigerState extends State<Tiger> {
  LayoutType _layoutSelection = LayoutType.home;

  Widget _buildBody() {
    LayoutType layoutSelection = _layoutSelection;
    switch (layoutSelection) {
      case LayoutType.home:
        return HomePage();
      case LayoutType.order:
        return OrderPage();
      case LayoutType.mine:
        return MinePage();
    }
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          _buildBottomNavBarItem(
            icon: _layoutSelection == LayoutType.home ? "images/home_select.png" : "images/home.png",
            layoutSelection: LayoutType.home
          ),
          _buildBottomNavBarItem(
              icon: _layoutSelection == LayoutType.order ? "images/order_select.png" : "images/order.png",
              layoutSelection: LayoutType.order
          ),
          _buildBottomNavBarItem(
              icon: _layoutSelection == LayoutType.mine ? "images/mine_select.png" : "images/mine.png",
              layoutSelection: LayoutType.mine
          )
        ],
      onTap: _onTabItem,
    );
  }

  void _onTabItem (int index) {
    switch (index) {
      case 0:
        _onTabItemSelect(LayoutType.home);
        break;
      case 1:
        _onTabItemSelect(LayoutType.order);
        break;
      case 2:
        _onTabItemSelect(LayoutType.mine);
        break;
    }
  }

  _onTabItemSelect (LayoutType selection) {
    setState(() {
      _layoutSelection = selection;
    });
  }

  Color _colorTabMatching({LayoutType layoutSelection}) {
    return _layoutSelection == layoutSelection ? Color(0xff00aeff) : Colors.grey;
  }

  BottomNavigationBarItem _buildBottomNavBarItem ({ String icon, LayoutType layoutSelection }) {
    String text = layoutName(layoutSelection);
    return BottomNavigationBarItem(
      icon: new Image.asset(
        icon,
        width: 22.0,
        height: 22.0,
      ),
      title: Text(
        text,
        style: TextStyle(
          color: _colorTabMatching(layoutSelection: layoutSelection),
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }
}