import 'package:flutter/material.dart';
import './style.dart' as style;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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
  var userImage;
  var userContent =[];

  addMyData() {
    var myData = {
    'id': result3.length,
    'image': userImage,
    'likes': 5,
    'date': 'July 25',
    'content': userContent[0],
    'liked': false,
    'user': userContent[1]
    };
    setState(() {
      result3.insert(0, myData);
    });
  }

  setUserContent(a) {
    setState(() {
      userContent.add(a);
    });
  }

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
              onPressed: () async{
                var picker = ImagePicker();
                var image = await picker.pickImage(source: ImageSource.gallery);
                if (image != null){
                  setState(() {
                    userImage = File(image.path);
                    print(userImage);
                  });
                }

                Navigator.push(context,
                MaterialPageRoute(builder: (c){
                  return Upload(
                      userImage: userImage,
                      setUserContent: setUserContent,
                      addMyData:addMyData);
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
                result3[i]["image"].runtimeType == String ?
                Image.network(result3[i]["image"]) : Image.file(result3[i]["image"]),
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

class Upload extends StatelessWidget {
 const Upload({Key? key,this.userImage,this.setUserContent,this.addMyData}) : super(key: key);
  final userImage;
  final setUserContent;
  final addMyData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(onPressed: (){
          addMyData();
        },
            icon: Icon(Icons.send))
      ],),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.file(userImage),
          TextField(onChanged: (text) {
             setUserContent(text);
          },
          ),
          TextField(onChanged: (text) {
            setUserContent(text);
          },
          ),

          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.close)
          ),
        ],
      ),
    );
  }
}



