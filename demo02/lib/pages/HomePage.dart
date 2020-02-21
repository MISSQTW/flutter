import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

Dio dio = new Dio();

String token =
    "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyTmFtZSI6IuaIkeaYr-Wdj-S6uiIsImlkIjozMTYsImNlbGxQaG9uZSI6IjE4MTU3MTc2NTA2IiwiaXNzIjoicmVzdGFwaXVzZXIiLCJhdWQiOiIwOThmNmJjZDQ2MjFkMzczY2FkZTRlODMyNjI3YjRmNiJ9.UHJwAXRtAtONKhoJwRKyEW7NmVtZe1mbnO_D2Wb-WCs";

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  List tabList = ['aaa', 'bbb'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: tabList.length,
        child: Scaffold(
          appBar: new AppBar(
            backgroundColor: new Color.fromRGBO(255, 255, 255, 1.0),
            automaticallyImplyLeading: false,
            titleSpacing: 0.0,
            title: new Center(
              child: new TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  isScrollable: true,
                  labelColor: new Color.fromRGBO(51, 51, 51, 1.0),
                  unselectedLabelColor: new Color.fromRGBO(153, 153, 153, 1.0),
                  tabs: tabList.map((tab) {
                    return new Tab(
                      text: tab,
                    );
                  }).toList()),
            ),
          ),
          body: new TabBarView(
              children: tabList.map((tab) {
            return OrderLists(type: 10000);
          }).toList()),
        ));
  }
}

class OrderLists extends StatefulWidget {
  final int type;

  @override
  OrderLists({Key key, this.type}) : super(key: key);

  @override
  OrderListsState createState() => new OrderListsState();
}

class OrderListsState extends State<OrderLists> {
  List orderList = List();
  ScrollController _controller = new ScrollController();
  bool showToTopBtn = false; //是否显示“返回到顶部”按钮
  int page = 1;
  bool isLoadMore = true;
  var _futureBuilderFuture;


  Future _getOrderList({int localPage = 0, int limit = 2, int categoryId: 10000}) async {
    dio.transformer = new MyTransformer();
    Response response = await dio.post("https://laohuq.com/api/News/Info",
        data: {"categoryId": categoryId, "page": localPage, "limit": limit},
        options: Options(headers: {"token": token}));
    if (response.statusCode == 200) {
      if (response.data['code'] == 0) {
        var _total = response.data['total'];
        setState(() {
          isLoadMore = !((_total ~/ limit) == localPage);
          page = localPage + 1;
        });

//        for (dynamic data in response.data['data']) {
//          print("data =========> ${data}");
//          orderList.add(data);
//        }
        dynamic data = response.data['data'];
        orderList.addAll(data);
        return orderList;
      }
    } else {
      throw Exception('Faid to load post');
    }
  }

  @override
  void initState() {
    //监听滚动事件，打印滚动位置
    _futureBuilderFuture = _getOrderList(localPage: page, categoryId: widget.type);
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent && isLoadMore) {
        _getOrderList(localPage: page, categoryId: widget.type);
      }
    });
  }

  @override
  void dispose() {
    //为了避免内存泄露，需要调用_controller.dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
      future: _futureBuilderFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
//          orderList = snapshot.data;
          return new ListView.builder(
            itemCount: orderList.length,
            controller: _controller,
            itemBuilder: (context, index) {
              var item = orderList[index];
              return createItem(item);
            },
          );
        } else if (snapshot.hasError) {
          return new Center(
            child: new Text("error2>>>>>>>>>>>>>>>:${snapshot.error}"),
          );
        }
        return new Center(
          child: new Text("正在加载中..."),
        );
      },
    );
  }

  Widget createItem(itemInfo) {
    List arrs = [1, 2, 3];
    List tags = ['3-8年', '携带工具'];
    List lables = ['3小时', '45s'];
    return Container(
      decoration: BoxDecoration(
        border:
            Border(bottom: BorderSide(width: 10.0, color: Color(0xfff3f4f5))),
      ),
      margin: EdgeInsets.only(top: 16.0),
      child: Column(
        children: <Widget>[
          new Container(
            margin: EdgeInsets.only(left: 10.0, right: 10.0),
            padding: EdgeInsets.only(bottom: 15.0),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Expanded(
                    flex: 0,
                    child: new Container(
                      width: 45.0,
                      height: 45.0,
                      child: Center(
                        child: new Image(
                          image: AssetImage('images/home.png'),
                          width: 45.0,
                          height: 45.0,
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4.0))),
                    )),
                new Expanded(
                  flex: 1,
                  child: new Container(
                    margin: EdgeInsets.only(left: 10.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text(
                              '需求种类-电焊',
                              style: TextStyle(
                                  color: Color(0xff222222),
                                  fontWeight: FontWeight.bold),
                            ),
                            new Text(
                              '¥600',
                              style: TextStyle(
                                  color: Color(0xffFF5000),
                                  fontSize: 21.0,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                        new Container(
                          margin: EdgeInsets.only(bottom: 9.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Row(
                                children: tags
                                    .asMap()
                                    .map((i, tag) => MapEntry(
                                        i,
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: i == 0 ? 0 : 9.0,
                                              right: i == tags.length - 1
                                                  ? 0
                                                  : 9.0),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  right: BorderSide(
                                                      width: 1.0,
                                                      color: Color(
                                                          i == tags.length - 1
                                                              ? 0x00e8e8e8
                                                              : 0xffe8e8e8)))),
                                          child: new Text(
                                            tag,
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Color(0xff666666)),
                                          ),
                                        )))
                                    .values
                                    .toList(),
                              ),
                              new Text(
                                '2019年07月08日 17:22',
                                style: TextStyle(
                                  color: Color(0xff666666),
                                  fontSize: 12.0,
                                ),
                              )
                            ],
                          ),
                        ),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Row(
                              children: lables.map((lab) {
                                return new Container(
                                  width: 64.0,
                                  height: 22.0,
                                  margin: EdgeInsets.only(right: 8.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xffff9c00),
                                    borderRadius: BorderRadius.circular(2.0),
                                  ),
                                  child: new Center(
                                    child: new Text(
                                      lab,
                                      style: TextStyle(
                                          color: Color(0xffffffff),
                                          fontSize: 13.0),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            new Container(
                              child: new Text(
                                '约3.6KM',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Color(0xff454545),
                                ),
                              ),
                            )
                          ],
                        ),
                        new Container(
                          margin: EdgeInsets.only(bottom: 4.0, top: 6.0),
                          child: new Text(
                            '联系电话：18434393238',
                            style: TextStyle(
                                fontSize: 13.0, color: Color(0xff535353)),
                          ),
                        ),
                        new Container(
                          child: new Text(
//                            '详细地址：杭州市下城区跨贸小镇12幢1407室',
                            itemInfo['title'],
                            style: TextStyle(
                                fontSize: 13.0, color: Color(0xff535353)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          new Container(
            margin: EdgeInsets.only(left: 10.0, right: 10.0),
            decoration: new BoxDecoration(
                border: Border(
                    top: BorderSide(width: 1.0, color: Color(0xffe2e3e3)))),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: arrs.map((arr) {
                return Container(
                  margin: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0),
                  child: Center(
                    child: Text(
                      '待抢单',
                      style: TextStyle(
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                  width: 90.0,
                  height: 32.0,
                  decoration: new BoxDecoration(
                    color: Color(0xff00aeff), // 底色
                    borderRadius:
                        BorderRadius.all(Radius.circular(16.0)), // 也可控件一边圆角大小
                  ),
                );
              }).toList(),
            ),
          ) // 底部按钮 待抢单 待接单
        ],
      ),
    );
  }
}

class MyTransformer extends DefaultTransformer {
  @override
  Future<String> transformRequest(RequestOptions options) async {
    if (options.data is List<String>) {
      throw new DioError(message: "Can't send List to sever directly");
    } else {
      return super.transformRequest(options);
    }
  }

  /// The [Options] doesn't contain the cookie info. we add the cookie
  /// info to [Options.extra], and you can retrieve it in [ResponseInterceptor]
  /// and [Response] with `response.request.extra["cookies"]`.
  @override
  Future transformResponse(
      RequestOptions options, ResponseBody response) async {
    return super.transformResponse(options, response);
  }
}
