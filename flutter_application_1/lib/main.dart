import 'package:flutter/material.dart';
import './style.dart' as style;
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(
    MaterialApp(
      theme: style.theme,
      home: MyApp() 
   )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var state =0;
  var tab = 0;
  var result3 = [];

  getData() async {
    var result = await http.get(Uri.parse('https://codingapple1.github.io/app/data.json'));
    if (result.statusCode == 200) {
      print("성공 "+result.statusCode.toString() );
    } else {
      print("에러 " + result.statusCode.toString());
    }
      var result2 = jsonDecode(result.body);
      result3 =result2;
      print(result3[0]);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wave.AI'),
        actions: [
          IconButton(
              onPressed: (){
                Navigator.push(context,
                MaterialPageRoute(builder: (c){
                  return Text('새페이지');
                }));
              },
              icon: Icon(Icons.add_box_outlined)
          )
        ],
      ),
      body: [postSet(result3: result3,),Text('샵페이지')][tab],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (i){
          setState((){
            tab = i;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: '샵'),
        ],
      )
    );
  }
}

class postSet extends StatelessWidget {
  postSet({Key? key,this.result3}) : super(key: key);

  var result3;
  var a = 5;

  @override
  Widget build(BuildContext context) {

    if (result3.isNotEmpty){
      return ListView.builder(
        itemCount: 3,
        itemBuilder: (context, i) {

          return Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Column(
              children: [
                Image.network(result3[i]["image"].toString()),
                Container(
                  constraints: BoxConstraints(maxWidth: 600),
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('좋아요 : ${result3[i]["likes"]}'),
                      Text('글쓴이 : ${result3[i]["user"]}'),
                      Text('글내용 : ${result3[i]["content"]}'),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    } else {
      return Text("로딩중");
    }

  }
}


