import 'package:flutter/material.dart';
import 'package:music_quiz/datas/point_data.dart';
import 'package:music_quiz/datas/quiz_data.dart';
import 'package:music_quiz/datas/update_Stage.dart';

import 'package:music_quiz/models/quiz_model.dart';
import 'package:music_quiz/pages/home_page.dart';
import 'dart:math';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:music_quiz/datas/userCheck_data.dart';
import '../models/userCheck_model.dart';
import 'package:just_audio/just_audio.dart';
import 'package:intl/intl.dart';



class Quiz_Page extends StatefulWidget{
  @override
  _Quiz_PageState createState() => _Quiz_PageState();
}

class _Quiz_PageState extends State<Quiz_Page> {

  List<int> list = [0,1,2,3];
  List<Quiz> _quiz;
  int _counter;
  int Q_NO = 0;
  int point = 0;
  Random rnd = new Random();
  bool _isLoading;
  bool _isLoading2;
  String formatted = DateFormat('yMd').format(DateTime.now());
  List<User_Ck> _user_ck;
  final AudioPlayer _player = AudioPlayer();

  @override
  void dispose(){
    _player.dispose();
    super.dispose();
  }


  @override
  void initState(){
    _quiz = [];
    _getQuiz();
    list.shuffle();
    _isLoading = false;
    _isLoading2 = false;
    _user_ck = [];
    _initTexts();
    super.initState();
  }

  //kakao account
  _initTexts() async{
    final User user = await UserApi.instance.me();
    setState(() {
      user_id = user.kakaoAccount.email;
    });
    _getUserCheck();
  }
  String user_id = 'None';


  _getUserCheck(){
    UserCheck_Data.getUserCheck(user_id).then((user_ck){
      setState(() {
        _user_ck = user_ck;
      });
      if(user_ck[0].stage == null){
        _isLoading2 = false;
      }else{
        _isLoading2 = true;
        if(user_ck[0].formatted == formatted){
          _counter = int.parse(user_ck[0].stage);
        }else{
          _counter = 0;
        }

      }
    });
  }

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('게임종료'),
        content: new Text('게임을 완전히 종료하시겠습니까?'),
        actions: <Widget>[
          new GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: roundedButton("No", const Color(0xFFff8a7d),
                const Color(0xFFFFFFFF)),
          ),
          new GestureDetector(
            onTap: () => Navigator.of(context).pop(true),
            child: roundedButton(" Yes ", const Color.fromRGBO(116, 116, 191, 1.0),
                const Color(0xFFFFFFFF)),
          ),
        ],
      ),
    ) ??
        false;
  }

  Widget roundedButton(String buttonLabel, Color bgColor, Color textColor) {
    var loginBtn = new Container(
      height: 40.0,
      width: 80.0,
      padding: EdgeInsets.all(5.0),
      alignment: FractionalOffset.center,
      decoration: new BoxDecoration(
        color: bgColor,
        borderRadius: new BorderRadius.all(const Radius.circular(2.0)),
      ),
      child: Text(
        buttonLabel,
        style: new TextStyle(
            color: textColor, fontSize: 12.0, fontWeight: FontWeight.bold),
      ),
    );
    return loginBtn;
  }

  //stage 20이 넘었을 때 Alert
  _onAlertButtonsPressed(context) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "점수 기록 종료",
      desc: "오늘의 문제를 모두 푸셨습니다. 이후의 문제는 점수가 기록되지 않습니다.",
      buttons: [
        DialogButton(
          child: Text(
            "종료",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => HomePage()), (route) => false),
          color: Color(0xFFff8a7d),
        ),
        DialogButton(
          child: Text(
            "계속하기",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () => Navigator.pop(context),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0),
          ]),
        )
      ],
    ).show();
  }

  //Exit Button 클릭 시 Alert
  _onExitButtonsPressed(context) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "게임 종료",
      desc: "홈 화면으로 돌아가시겠습니까?",
      buttons: [
        DialogButton(
          child: Text(
            "종료",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => HomePage()), (route) => false),
          color: Color(0xFFff8a7d),
        ),
        DialogButton(
          child: Text(
            "계속하기",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () => Navigator.pop(context),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0),
          ]),
        )
      ],
    ).show();
  }

  //stage 증가
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  //MySQL에서 Quiz 정보 불러오기
  _getQuiz(){
    Quiz_Data.getQuiz().then((quiz){
      setState(() {
        _quiz = quiz;
      });
      if(quiz[0].answer == null){
        _isLoading = false;
      }else{
        _isLoading = true;
      }
    });
  }

  _addPoint(){
    Point_Data.addPoint(user_id, point.toString()).then((result){
      if('success' == result){
        print('point save success');
      }
    });
  }

  _updateStage(){
    UpdateStage.updateStage(formatted, user_id).then((result){
      if('success' == result){
        print('stage update success');
      }
    });
  }

  //Quiz 정답 시 다음문제 넘어가기
  void nextSuccessQuestion(){
    setState(() {
      if(_counter < 19){
        int min = 0;
        int max = _quiz.length;
        Q_NO = min + rnd.nextInt(max - min);
        _player.setAsset('assets/sounds/success.mp3');
        _player.play();
        point += 30;
        _incrementCounter();
      }else if(_counter < 20){
        int min = 0;
        int max = _quiz.length;
        Q_NO = min + rnd.nextInt(max - min);
        _player.setAsset('assets/sounds/success.mp3');
        _player.play();
        _incrementCounter();
        point += 30;
        _addPoint();
        _updateStage;
        _onAlertButtonsPressed(context);
      }else{
        int min = 0;
        int max = _quiz.length;
        Q_NO = min + rnd.nextInt(max - min);
        _player.setAsset('assets/sounds/success.mp3');
        _player.play();
        _incrementCounter();
      }
    });
  }

  //Quiz 실패 시 다음문제 넘어가기
  void nextFailQuestion(){
    setState(() {
      if(_counter < 19){
        int min = 0;
        int max = _quiz.length;
        Q_NO = min + rnd.nextInt(max - min);
        _player.setAsset('assets/sounds/fail.mp3');
        _player.play();
        point -= 10;
        _incrementCounter();
      }else if(_counter < 20){
        int min = 0;
        int max = _quiz.length;
        Q_NO = min + rnd.nextInt(max - min);
        _player.setAsset('assets/sounds/fail.mp3');
        _player.play();
        _incrementCounter();
        point -= 30;
        _addPoint();
        _updateStage();
        _onAlertButtonsPressed(context);
      }else{
        int min = 0;
        int max = _quiz.length;
        Q_NO = min + rnd.nextInt(max - min);
        _player.setAsset('assets/sounds/fail.mp3');
        _player.play();
        _incrementCounter();
      }
    });
  }


  //Quiz 정답 정보 불러오기
  String getAnswer(){
    print(_quiz[Q_NO].answer);
    return _quiz[Q_NO].answer;
  }

  //Quiz 보기1 정보 불러오기
  String getChoice1(){
    print(_quiz[Q_NO].choice1);
    return _quiz[Q_NO].choice1;
  }

  //Quiz 보기2 정보 불러오기
  String getChoice2(){
    print(_quiz[Q_NO].choice2);
    return _quiz[Q_NO].choice2;
  }

  //Quiz 보기3 정보 불러오기
  String getChoice3(){
    print(_quiz[Q_NO].choice3);
    return _quiz[Q_NO].choice3;
  }

  //Quiz 보기4 정보 불러오기
  String getChoice4(){
    print(_quiz[Q_NO].choice4);
    return _quiz[Q_NO].choice4;
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: _isLoading2
          ?
          Text("Stage ${_counter+1}", style: TextStyle(color: Colors.black),)
          :
          CircularProgressIndicator(),
          leading: IconButton(icon: Icon(Icons.close, color: Colors.black,), onPressed: (){_onExitButtonsPressed(context);},),
        ),
        backgroundColor: Colors.white,
        body: WillPopScope(
          onWillPop: _onBackPressed,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              child: Row(
                children: <Widget>[
                  Spacer(),
                  _isLoading && _isLoading2
                      ?
                  Column(
                    children: <Widget>[
                      Text('$point', style:
                        TextStyle(
                            fontSize: 20.0,
                            color: Colors.redAccent
                        ),
                      ),
                      SizedBox(height: 40.0,),
                      Image.asset('assets/images/sound.png', width: MediaQuery.of(context).size.width*0.8, fit: BoxFit.cover),
                      SizedBox(height: 45.0,),
                      Container(
                        height: 40.0,
                        width: MediaQuery.of(context).size.width * 0.6,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(width: 1.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: Offset(3, 3),
                              )
                            ]
                        ),
                        child: FlatButton(
                          textColor: Colors.black,
                          child: Text(getChoice1()),
                          onPressed: (){
                            if(_quiz[Q_NO].choice1 == _quiz[Q_NO].answer){
                              nextSuccessQuestion();
                              print('success');
                            }else{
                              nextFailQuestion();
                              print('fail');
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 13.0),
                      Container(
                        height: 40.0,
                        width: MediaQuery.of(context).size.width * 0.6,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(width: 1.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: Offset(3, 3),
                              )
                            ]
                        ),
                        child: FlatButton(
                          textColor: Colors.black,
                          child: Text(getChoice2()),
                          onPressed: (){
                            if(_quiz[Q_NO].choice2 == _quiz[Q_NO].answer){
                              nextSuccessQuestion();
                              print('success');
                            }else{
                              nextFailQuestion();
                              print('fail');
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 13.0),
                      Container(
                        height: 40.0,
                        width: MediaQuery.of(context).size.width * 0.6,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(width: 1.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: Offset(3, 3),
                              )
                            ]
                        ),
                        child: FlatButton(
                          textColor: Colors.black,
                          child: Text(getChoice3()),
                          onPressed: (){
                            if(_quiz[Q_NO].choice3 == _quiz[Q_NO].answer){
                              nextSuccessQuestion();
                              print('success');
                            }else{
                              nextFailQuestion();
                              print('fail');
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 13.0),
                      Container(
                        height: 40.0,
                        width: MediaQuery.of(context).size.width * 0.6,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(width: 1.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: Offset(3, 3),
                              )
                            ]
                        ),
                        child: FlatButton(
                          textColor: Colors.black,
                          child: Text(getChoice4()),
                          onPressed: (){
                            if(_quiz[Q_NO].choice4 == _quiz[Q_NO].answer){
                              nextSuccessQuestion();
                              print('success');
                            }else{
                              nextFailQuestion();
                              print('fail');
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 40),
                      Container(
                          width: MediaQuery.of(context).size.width*0.9,
                          height: MediaQuery.of(context).size.height*0.07,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1.0, color: Colors.grey)
                          ),
                          child: Text('Banner AD')
                      ),
                    ],
                  )
                      :
                  CircularProgressIndicator(),
                  Spacer(),
                ],
              ),
            ),
          ),
        )
      )
    );
  }
}