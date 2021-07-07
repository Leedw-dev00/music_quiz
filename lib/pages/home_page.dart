import 'package:flutter/material.dart';
import 'package:music_quiz/pages/profile.dart';
import 'package:music_quiz/pages/quiz_page.dart';
import 'package:music_quiz/pages/rank_page.dart';
import 'package:music_quiz/datas/userRegister_data.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:music_quiz/datas/userRegister_data.dart';
import 'package:music_quiz/datas/userCheck_data.dart';
import '../models/userCheck_model.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  List<User_Ck> _user_ck;
  bool _isUserCheck = false;

  @override
  void dispose(){
    super.dispose();
  }

  @override
  void initState(){
    _user_ck = [];
    _getUserCheck();
    _initTexts();
    _isUserCheck;
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

  _addUserRegister(){
    UserRegister_Data.addUser(user_id).then((result){
      if('success' == result){
        print('aa');
      }
    });
  }

  _getUserCheck(){
    UserCheck_Data.getUserCheck(user_id).then((user_ck){
      setState(() {
        _user_ck = user_ck;
      });
      if(user_ck.length == 0){
        _isUserCheck = false;
      }else{
        _isUserCheck = true;
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF70BFB5),
      body: Container(
        width: MediaQuery.of(context).size.width,
            child: Stack(
              children: <Widget>[
                Image.asset('assets/images/home_back1.png', width: MediaQuery.of(context).size.width, fit: BoxFit.cover,),
                Positioned(child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          child: Image.asset('assets/images/quiz_btn.png'),
                          onTap: (){
                            if(_isUserCheck){
                              print('Already exsited');
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Quiz_Page()),);
                            }else{
                              print('save success');
                              _addUserRegister();
                            }
                          },
                        ),
                        SizedBox(height: 10.0),
                        GestureDetector(
                          child: Image.asset('assets/images/rank_btn.png'),
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Rank_Page(),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 10.0),
                        GestureDetector(
                          child: Image.asset('assets/images/my_btn.png'),
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Profile_page(),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 115.0,),
                      ],
                    ),
                  ],
                )
                )
              ],
            )
          ),
        );

  }
}

