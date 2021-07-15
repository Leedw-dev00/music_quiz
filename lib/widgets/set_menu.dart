import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:music_quiz/datas/deleteUser_data.dart';
import 'package:music_quiz/pages/login_page.dart';


class Set_Menu extends StatefulWidget{
  @override
  _Set_MenuState createState() => _Set_MenuState();
}

class _Set_MenuState extends State<Set_Menu>{

  @override
  void dispose(){
    super.dispose();
  }

  @override
  void initState(){
    _initTexts();
    super.initState();
  }

  //kakao account
  _initTexts() async{
    final User user = await UserApi.instance.me();
    setState(() {
      user_id = user.kakaoAccount.email;
    });
  }
  String user_id = 'None';


  _deleteUser(){
    Delete_User.deleteUser(user_id).then((result){
      if('success' == result){
        print('delete success');
      }
    });
  }


  @override
  Widget build(BuildContext context) {

    _logout() async{
      await UserApi.instance.logout();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => loginPage()));
    }



    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 15.0,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Color(0xFFf7f7f7)
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: <Widget>[
                TextButton(child: Text('회원탈퇴', style: TextStyle(fontSize: 15.0),), onPressed: (){
                  _deleteUser();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => loginPage()));
                },),
              ],
            ),
          ),
          Container(
            height: 1.0,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Color(0xFFdbdbdb)
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: <Widget>[
                TextButton(child: Text('로그아웃', style: TextStyle(fontSize: 15.0),), onPressed: (){_logout();},),
              ],
            ),
          ),
          Container(
            height: 1.0,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Color(0xFFdbdbdb)
            ),
          ),
        ],
      ),
    );
  }
}