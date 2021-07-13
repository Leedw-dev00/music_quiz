import 'dart:core';
import 'package:flutter/material.dart';
import 'package:music_quiz/datas/rankDelete_data.dart';
import 'package:music_quiz/datas/rank_data.dart';
import 'package:music_quiz/pages/quiz_page.dart';
import 'package:kakao_flutter_sdk/all.dart';
import '../datas/rank_data.dart';
import '../models/rank_model.dart';


class Rank_Page extends StatefulWidget{
  _Rank_PageState createState() => _Rank_PageState();
}

class _Rank_PageState extends State<Rank_Page> with WidgetsBindingObserver{

  List<Rank> _rank;
  bool _isLoading;
  int differenceInHours = ((DateTime.now().difference(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + (2 - DateTime.now().weekday))).inMinutes.round()*-1)) ~/ 60;
  int differenceInMinutes = ((DateTime.now().difference(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + (2 - DateTime.now().weekday))).inMinutes.round()*-1)) % 60;
  String durationToString(int minutes) {
    var d = Duration(minutes:minutes);
    List<String> parts = d.toString().split(':');
    return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
  }



  @override
  void dispose(){
    super.dispose();
  }

  @override
  void initState(){
    _isLoading = false;
    _initTexts();
    _rank = [];
    _getRank();
    super.initState();
    differenceInMinutes;
    differenceInHours;
  }

  _initTexts() async{
    final User user = await UserApi.instance.me();
    setState(() {
      user_id = user.kakaoAccount.email;
    });
  }
  String user_id = 'None';

  _getRank(){
    Rank_Data.getRank().then((rank){
      setState(() {
        _rank = rank;
      });
      if(rank[0].point == null){
        _isLoading = false;
      }else{
        _isLoading = true;
        if(differenceInHours == 0 && differenceInMinutes == 0){
          _deleteRank();
        }
      }
    });
  }

  _deleteRank(){
    RankDelete_Data.deleteRank().then((result){
      if('success' == result){
        print("Delete Good");
      }
      _getRank();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF848FD8),
        elevation: 0.0,
        title: Text('Rank', style: TextStyle(color: Colors.white),),
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.white),
          onPressed: (){Navigator.pop(context);},
        ),
        actions: [
          IconButton(icon: Icon(Icons.contact_support_outlined, color: Colors.white,), onPressed: (){})
        ],
      ),
      backgroundColor: Color(0xFF848FD8),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(height: 30.0,),
                Container(
                  height: MediaQuery.of(context).size.height*0.63,
                  width: MediaQuery.of(context).size.width,
                  color: Color(0xFFAFB5E2),
                  child: Column(
                    children: <Widget>[
                      Spacer(),
                      Row(
                        children: <Widget>[
                          SizedBox(width: 20.0),
                          Text('1-50th', style: TextStyle(color: Colors.white, fontSize: 23.0),),
                          Spacer(),
                          Text('${differenceInHours}시간 ${differenceInMinutes}분 후 초기화', style: TextStyle(fontSize: 14.0, color: Colors.black54),),
                          SizedBox(width: 20.0),
                        ],
                      ),
                      Spacer(),
                      _isLoading
                      ?
                      Container(
                        height: MediaQuery.of(context).size.height*0.55,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: ListView.builder(
                          padding: EdgeInsets.all(5.0),
                          scrollDirection: Axis.vertical,
                          itemCount: _rank.length,
                          itemBuilder: (BuildContext context, int index){
                            return Container(
                              child: Column(
                                children: <Widget>[
                                  SizedBox(height: 10.0,),
                                  Row(
                                    children: <Widget>[
                                      SizedBox(width: 20.0,),
                                      Text('${index + 1}', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                                      Spacer(),
                                      Text(_rank[index].user_id, style: TextStyle(fontWeight: FontWeight.w600),),
                                      Spacer(),
                                      Text(_rank[index].point, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.redAccent),),
                                      SizedBox(width: 20.0,),
                                    ],
                                  ),
                                  SizedBox(height: 10.0,),
                                  Container(
                                      height: 0.5,
                                      width: MediaQuery.of(context).size.width,
                                      color: Color(0xFF707070),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      )
                      :
                      Container(
                        height: MediaQuery.of(context).size.height*0.55,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Spacer(),
                              Text('랭킹 없음! Play 버튼을 클릭하여 랭킹을 등록 해주세요', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.0,),
                GestureDetector(
                  child: Image.asset('assets/images/play_btn.png', width: MediaQuery.of(context).size.width*0.55, fit: BoxFit.cover,),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Quiz_Page(),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}