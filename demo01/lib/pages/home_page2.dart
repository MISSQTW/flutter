import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController typeController = TextEditingController();
  String showText = '欢迎来到天上人间';

  @override
  Widget build(BuildContext context) {
    return Container(

      child: Scaffold(
        appBar: AppBar(
          title: Text('美好人间'),
        ),
        body: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: typeController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  labelText: '美女类型',
                  helperText: '请输入你喜欢的类型'
                ),
                autofocus: false,
              ),
              RaisedButton(
                onPressed: _choiceAction,
                child: Text('选择完毕'),
              ),
              Text(
                showText,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  void _choiceAction() {
    print("开始选择你喜欢的类型。。。。。。");
    if (typeController.text.toString() == "") {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(title: Text("美女类型不能为空"))
      );
    } else{
      postHttp(typeController.text.toString()).then((val){
        setState(() {
          showText = val['data']['name'].toString();
        });
      });
    }
  }

  Future getHttp(String TypeText) async{
    try{
      Response response;
      var data = { "name": TypeText };
      response = await Dio().get(
        "https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian",
        queryParameters: data
      );
      return response.data;
    }catch(e) {
      return print(e);
    }
  }

  Future postHttp(String TypeText) async{
    try{
      Response response;
      var data = { "name": TypeText };
      response = await Dio().post(
          "https://www.easy-mock.com/mock/5d50058860cb0509dc687e46/api/post_love",
          queryParameters: data
      );
      return response.data;
    }catch(e) {
      return print(e);
    }
  }
}

