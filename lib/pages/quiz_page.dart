import 'package:flutter/material.dart';
import 'package:music_quiz/datas/quiz_data.dart';

import 'package:music_quiz/models/quiz_model.dart';
import 'package:music_quiz/pages/home_page.dart';
import 'dart:math';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Quiz_Page extends StatefulWidget{
  @override
  _Quiz_PageState createState() => _Quiz_PageState();
}

class _Quiz_PageState extends State<Quiz_Page> {

  List<int> list = [0,1,2,3];
  List<Quiz> _quiz;
  int _counter = 0;
  int Q_NO = 0;
  int point = 0;
  Random rnd = new Random();
  bool _isLoading;


  @override
  void initState(){
    _quiz = [];
    _getQuiz();
    list.shuffle();
    _counter;
    _isLoading = false;
    super.initState();
  }

  //stage 증가
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
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
      desc: "게임을 종료하시겠습니까?",
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

  //Quiz 정답 시 다음문제 넘어가기
  void nextQuestion(){
    setState(() {
      if(_counter < 2){
        int min = 0;
        int max = _quiz.length;
        Q_NO = min + rnd.nextInt(max - min);
        point += 30;
        _incrementCounter();
      }else if(_counter < 3){
        int min = 0;
        int max = _quiz.length;
        Q_NO = min + rnd.nextInt(max - min);
        _incrementCounter();
        _onAlertButtonsPressed(context);
      }else{
        int min = 0;
        int max = _quiz.length;
        Q_NO = min + rnd.nextInt(max - min);
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
          title: Text("Stage $_counter", style: TextStyle(color: Colors.black),),
          leading: IconButton(icon: Icon(Icons.close, color: Colors.black,), onPressed: (){_onExitButtonsPressed(context);},),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            child: Row(
              children: <Widget>[
                Spacer(),
                _isLoading
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
                            nextQuestion();
                            print('success');
                          }else{
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
                            nextQuestion();
                            print('success');
                          }else{
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
                            nextQuestion();
                            print('success');
                          }else{
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
                            nextQuestion();
                            print('success');
                          }else{
                            print('fail');
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 70),
                    Container(
                      width: MediaQuery.of(context).size.width*0.9,
                      height: 70.0,
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

    );
  }
}