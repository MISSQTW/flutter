import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String homePageContent = "正在获取数据";

  @override
  void initState() {
//    getHomePageContent().then((val){
//      setState(() {
//        homePageContent = val.toString();
//      });
//    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List <Map> swiper = [
      {
        'image': 'https://c-ssl.duitang.com/uploads/item/201807/30/20180730193853_rgxrt.jpg'
      },
      {
        'image': 'http://b-ssl.duitang.com/uploads/item/201808/05/20180805105613_nnygy.jpg'
      },
      {
        'image': 'http://pic1.win4000.com/wallpaper/2018-09-21/5ba45e713df2e.jpg'
      }
    ];
    List<Map> navigatorList = [
      {
        'image': 'https://c-ssl.duitang.com/uploads/item/201807/30/20180730193853_rgxrt.jpg',
        'name': 'kiku'
      },
      {
        'image': 'http://b-ssl.duitang.com/uploads/item/201808/05/20180805105613_nnygy.jpg',
        'name': 'shayne'
      },
      {
        'image': 'http://pic1.win4000.com/wallpaper/2018-09-21/5ba45e713df2e.jpg',
        'name': 'kuku'
      },
      {
        'image': 'https://c-ssl.duitang.com/uploads/item/201807/30/20180730193853_rgxrt.jpg',
        'name': 'kiku'
      },
      {
        'image': 'http://b-ssl.duitang.com/uploads/item/201808/05/20180805105613_nnygy.jpg',
        'name': 'shayne'
      },
      {
        'image': 'http://pic1.win4000.com/wallpaper/2018-09-21/5ba45e713df2e.jpg',
        'name': 'kuku'
      }

    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("百姓生活+"),
      ),
      body: Column(
        children: <Widget>[
          SwiperDiy(swiperDataList: swiper),
          TopNavigator(navigatorList: navigatorList,)
        ],
      ),
    );
  }
}

//首页轮播图
class SwiperDiy extends StatelessWidget {

  final List swiperDataList;

  SwiperDiy({ Key key, this.swiperDataList }):super(key: key);

  @override
  Widget build(BuildContext context) {
    print('设备像素密度${ScreenUtil.pixelRatio}');
    print('设备的高${ScreenUtil.screenHeight}');
    print('设备的宽${ScreenUtil.screenWidth}');
    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network('${swiperDataList[index]['image']}', fit: BoxFit.cover,);
        },
        itemCount: swiperDataList.length,
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

// 
class TopNavigator extends StatelessWidget {
  final List navigatorList;
  
  TopNavigator({Key key, this.navigatorList}):super(key: key);
  
  Widget _gridViewItemUI(BuildContext context, item) {
    return InkWell(
      onTap: () {print('tap navigator');},
      child: Column(
        children: <Widget>[
          Image.network(item['image'], width: ScreenUtil().setWidth(95)),
          Text(item['name'])
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        crossAxisCount: 5,
        padding: EdgeInsets.all(5.0),
        children: navigatorList.map((item){
          return _gridViewItemUI(context, item);
        }).toList()
      ),
    );
  }
}


