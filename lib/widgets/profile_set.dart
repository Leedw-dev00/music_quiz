import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/all.dart';

class Profile_Set extends StatefulWidget {
  @override
  _Profile_Set createState() => _Profile_Set();
}

class _Profile_Set extends State<Profile_Set>{

  @override
  void dispose(){
    super.dispose();
  }

  @override
  void initState(){
    _initTexts();
    super.initState();
  }

  _initTexts() async{
    final User user = await UserApi.instance.me();
    setState(() {
      user_id = user.kakaoAccount.email;
      user_name = user.kakaoAccount.profile.nickname;
      user_birth = user.kakaoAccount.birthday;
      user_gender = user.kakaoAccount.gender;
    });
  }
  String user_id = 'None';
  String user_name = 'None';
  String user_birth = 'None';
  Gender user_gender;



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Spacer(),
              Container(
                  width: MediaQuery.of(context).size.width*0.7,
                  height: 40.0,
                  decoration: BoxDecoration(
                      color: Color(0xFFd4d4d4),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('$user_id', style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),)
                    ],
                  )
              ),
              Spacer(),
            ],
          ),
          SizedBox(height: 20.0,),
          Row(
            children: <Widget>[
              SizedBox(width: 30.0,),
              Text('성별', style: TextStyle(fontSize: 14.0),)
            ],
          ),
          SizedBox(height: 5.0,),

          user_gender == Gender.MALE
          ?
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                      height: 40.0,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1.0, color: Color(0xFFE73250)),
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text('남', style: TextStyle(fontSize: 15.0),)
                        ],
                      )
                  ),
                ),
                SizedBox(width: 10.0,),
                Expanded(
                  flex: 1,
                  child: Container(
                      height: 40.0,

                      decoration: BoxDecoration(
                          border: Border.all(width: 1.0, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text('여', style: TextStyle(fontSize: 15.0),)
                        ],
                      )
                  ),
                )
              ],
            ),
          )
          :
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              children: <Widget>[
                Container(
                    height: 40.0,
                    width: 130.0,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text('남', style: TextStyle(fontSize: 15.0),)
                      ],
                    )
                ),
                Spacer(),
                Container(
                    height: 40.0,
                    width: 130.0,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Color(0xFFE73250)),
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text('여', style: TextStyle(fontSize: 15.0),)
                      ],
                    )
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0,),
          Row(
            children: <Widget>[
              SizedBox(width: 30.0,),
              Text('생년월일', style: TextStyle(fontSize: 14.0),)
            ],
          ),
          SizedBox(height: 5.0,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              children: <Widget>[
                Container(
                    height: 40.0,
                    width: 84.0,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(user_birth.substring(0,2), style: TextStyle(fontSize: 15.0),)
                      ],
                    )
                ),
                SizedBox(width: 5.0,),
                Text('월'),
                SizedBox(width: 10.0,),
                Container(
                  height: 40.0,
                  width: 84.0,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1.0, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(user_birth.substring(2,4), style: TextStyle(fontSize: 15.0),)
                    ],
                  ),
                ),
                SizedBox(width: 5.0,),
                Text('일'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}