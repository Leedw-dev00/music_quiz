import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:music_quiz/pages/login_page.dart';


class Set_Menu extends StatelessWidget{


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
                TextButton(child: Text('회원탈퇴', style: TextStyle(fontSize: 15.0),), onPressed: (){},),
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