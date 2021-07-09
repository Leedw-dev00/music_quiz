import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:music_quiz/widgets/profile_set.dart';
import 'package:music_quiz/widgets/set_menu.dart';
import 'package:music_quiz/widgets/system_set.dart';



class Profile_page extends StatefulWidget{
  @override
  _Profile_pageState createState() => _Profile_pageState();
}

class _Profile_pageState extends State<Profile_page>{

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
      _default_Image = user.kakaoAccount.profile.isDefaultImage;
      profile_image = user.kakaoAccount.profile.profileImageUrl;
    });
  }
  String profile_image = 'None';
  bool _default_Image = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Profile', style:
          TextStyle(
            color: Colors.black,
          ),
        ),
        leading: IconButton(icon: Icon(Icons.close, color: Colors.black,), onPressed: (){Navigator.pop(context);}),
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 40.0),
                Row(
                  children: <Widget>[
                    Spacer(),
                    _default_Image
                      ?
                    Container(
                      width: 150.0,
                      height: 150.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/jeon.jpg'),
                        ),
                        border: Border.all(width: 1.0, color: Colors.grey, style: BorderStyle.solid),
                        color: Colors.white,
                        shape: BoxShape.circle
                      ),
                    )
                      :
                    Container(
                      width: 150.0,
                      height: 150.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(profile_image),
                          ),
                          border: Border.all(width: 1.0, color: Colors.grey, style: BorderStyle.solid),
                          color: Colors.white,
                          shape: BoxShape.circle
                      ),
                    ),

                    Spacer(),
                  ],
                ),
                SizedBox(height: 20.0,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('계정 설정', style:
                        TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                          color: Colors.black54
                        ),
                      ),
                      SizedBox(height: 2.0, width: 65.0, child: Container(color: Colors.black54,),)
                    ],
                  ),
                ),
                SizedBox(height: 20.0,),
                Profile_Set(),
                SizedBox(height: 50.0,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('시스템 설정', style:
                        TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                          color: Colors.black54
                        ),
                      ),
                      SizedBox(height: 2.0, width: 80.0, child: Container(color: Colors.black54,),),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                System_Set(),
                SizedBox(height: 50.0,),
                Set_Menu(),
              ],
            ),
          )
        ),
      ),
    );
  }
}